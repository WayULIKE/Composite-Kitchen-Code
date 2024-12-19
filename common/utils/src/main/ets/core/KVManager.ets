/*
 * @Desc: 数据持久化，缓存数据到本地（4M以下）
 * @Author: qincji
 * @Date: 2024/5/25
 */
import { distributedKVStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { log } from './Log';

const TAG = 'KVManager';

class KVManager {
  private kvManager?: distributedKVStore.KVManager;
  private kvStore: distributedKVStore.SingleKVStore | undefined = undefined;

  public init(context: Context) {
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: 'com.yuyeke.sleepwell'
    };
    try {
      // 创建KVManager实例
      this.kvManager = distributedKVStore.createKVManager(kvManagerConfig);
      log.i(TAG, 'Succeeded in creating KVManager.');
    } catch (e) {
      let error = e as BusinessError;
      log.e(TAG, `Failed to create KVManager. Code:${error.code},message:${error.message}`);
      return;
    }

    try {
      const options: distributedKVStore.Options = {
        createIfMissing: true,
        encrypt: false,
        backup: false,
        autoSync: false,
        // kvStoreType不填时，默认创建多设备协同数据库
        kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
        // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
        securityLevel: distributedKVStore.SecurityLevel.S1
      };
      this.kvManager.getKVStore<distributedKVStore.SingleKVStore>('storeId', options,
        (err, store: distributedKVStore.SingleKVStore) => {
          if (err) {
            log.e(TAG, `Failed to get KVStore: Code:${err.code},message:${err.message}`);
            return;
          }
          this.kvStore = store as distributedKVStore.SingleKVStore;
          log.i(TAG, 'Succeeded in getting KVStore.');
        });
    } catch (e) {
      let error = e as BusinessError;
      log.e(TAG, `An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  put(key: string, value: boolean | string | number | Uint8Array) {
    this.kvStore?.put(key, value, (err) => {
      if (err !== undefined) {
        log.e(TAG, `Failed to put data. Code:${err.code},message:${err.message}`);
        return;
      }
      log.i(TAG, 'Succeeded in putting data.');
    });
  }

  async get<T>(key: string, defVal: T): Promise<T> {
    try {
      const value = await this.kvStore?.get(key);
      if (value === undefined) {
        return defVal;
      }
      return value as T;
    } catch (e) {
      let error = e as BusinessError;
      log.e(TAG, `Failed to get data. Code:${error.code},message:${error.message}`);
      return defVal;
    }
  }

  delete(key: string) {
    this.kvStore?.delete(key, (err) => {
      if (err !== undefined) {
        log.e(TAG, `Failed to delete data. Code:${err.code},message:${err.message}`);
        return;
      }
      log.i(TAG, 'Succeeded in deleting data.');
    });
  }
}

export const kvManger = new KVManager();
