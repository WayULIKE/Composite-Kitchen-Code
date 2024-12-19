/*
 * @Desc: 获取设备id，1. @ohos.security.asset获取 2. AAID： aaid.getAAID()，然而卸载APP/恢复设备出厂设置/后会发生变化
 * @Author: qincji
 * @Date: 2024/6/7
 */
import { asset } from '@kit.AssetStoreKit';
import { util } from '@kit.ArkTS';
import { AAID } from '@kit.PushKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { log } from './Log';

interface Creator {
  generate(): Promise<string>;
}

const TAG = 'DeviceUtil';

class AssetCreator implements Creator {
  private key: string = 'asset_device_id';

  async generate(): Promise<string> {
    let id = await AssetCreator.getID(this.key);
    if (id !== undefined) {
      return id;
    }
    id = util.generateRandomUUID(true).replace('-', '');
    await AssetCreator.putID(this.key, id);
    return id;
  }

  private static async getID(key: string): Promise<string | undefined> {
    let query: asset.AssetMap = new Map();
    // 关键资产别名，每条关键资产的唯一索引。
    // 类型为Uint8Array，长度为1-256字节。
    query.set(asset.Tag.ALIAS, AssetCreator.stringToArray(key));
    //     关键资产查询返回的结果类型。
    query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);
    try {
      const data: Array<asset.AssetMap> = await asset.query(query);
      if (data === undefined || data.length === 0) {
        return undefined;
      }
      let secret: Uint8Array = data[0].get(asset.Tag.SECRET) as Uint8Array;
      return AssetCreator.arrayToString(secret);
    } catch (e) {
      let err = e as BusinessError;
      log.i(TAG, `Failed to query Asset. Code is ${err.code}, message is ${err.message}`);
    }
    return undefined;
  }

  private static async putID(key: string, value: string) {
    let attr: asset.AssetMap = new Map();
    // 关键资产别名，每条关键资产的唯一索引。
    // 类型为Uint8Array，长度为1-256字节。
    attr.set(asset.Tag.ALIAS, AssetCreator.stringToArray(key));
    // 关键资产明文。
    // 类型为Uint8Array，长度为1-1024字节
    attr.set(asset.Tag.SECRET, AssetCreator.stringToArray(value));

    // 关键资产同步类型>THIS_DEVICE只在本设备进行同步，如仅在本设备还原的备份场景。
    attr.set(asset.Tag.SYNC_TYPE, asset.SyncType.THIS_DEVICE);

    //枚举，新增关键资产时的冲突（如：别名相同）处理策略。OVERWRITE》抛出异常，由业务进行后续处理。
    attr.set(asset.Tag.CONFLICT_RESOLUTION, asset.ConflictResolution.THROW_ERROR)
    // 在应用卸载时是否需要保留关键资产。
    // 需要权限： ohos.permission.STORE_PERSISTENT_DATA。
    // 类型为bool。
    attr.set(asset.Tag.IS_PERSISTENT, true);

    try {
      await asset.add(attr);
    } catch (e) {
      let err = e as BusinessError;
      log.i(TAG, `Failed to add Asset. Code is ${err.code}, message is ${err.message}`);
    }
  }

  private static stringToArray(str: string): Uint8Array {
    let textEncoder = new util.TextEncoder();
    return textEncoder.encodeInto(str);
  }

  private static arrayToString(arr: Uint8Array): string {
    let textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    let str = textDecoder.decodeWithStream(arr, { stream: false });
    return str;
  }
}


class AAIDCreator implements Creator {
  async generate(): Promise<string> {
    const id = await AAID.getAAID();
    return id ? id : util.generateRandomUUID(true).replace('-', '');
  }
}


export class DeviceUtil {
  private static deviceId: string = '';

  /**
   * 获取设备ID
   * @returns
   */
  static async getDeviceID(): Promise<string> {
    if (DeviceUtil.deviceId) {
      return DeviceUtil.deviceId;
    }
    let creator: Creator;
    if (canIUse("SystemCapability.Security.Asset")) {
      creator = new AssetCreator();
    } else {
      creator = new AAIDCreator();
    }
    DeviceUtil.deviceId = await creator.generate();
    return DeviceUtil.deviceId;
  }
}
