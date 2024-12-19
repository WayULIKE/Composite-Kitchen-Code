/*
 * @Desc: 
 * @Author: qincji
 * @Date: 2024/6/8
 */
import { common, Want } from '@kit.AbilityKit';
import { global } from './Global';
import { RouterUtil } from './RouterUtil';

export class IntentUtil {
  /**
   * 跳转到本APP页面
   * @param url
   * @param title
   */
  static jumpWeb(url: string, title: string = '') {
    const record: Record<string, Object> = { 'url': url, 'title': title };
    RouterUtil.push('WebPage', record)
  }

  /**
   * 显式跳转的其他应用
   * @param deviceId
   * @param bundleName
   * @param abilityName
   */
  static jumpApp(deviceId: string, bundleName: string, abilityName: string) {
    let want: Want = {
      deviceId: deviceId, // deviceId为空表示本设备
      bundleName: bundleName,
      abilityName: abilityName,
    };

    IntentUtil.jumpWant(want)
  }

  /**
   * 隐式跳转到其他应用打开内容
   * @param deviceId
   * @param bundleName
   * @param abilityName
   */
  static jumpAction(action: string, entities: string, uri: string, type: string) {
    let want: Want = {
      action: action,
      entities: [entities], // entities can be omitted
      uri: uri,
      type: type,
    };

    IntentUtil.jumpWant(want)
  }

  /**
   * 跳转到浏览器
   * @param url
   */
  static jumpBrows(url: string) {
    let want: Want = {
      action: 'ohos.want.action.viewData',
      entities: ['entity.system.browsable'],
      uri: url
    }
    IntentUtil.jumpWant(want)
  }

  static jumpStore(appId: string) {
    const want: Want = {
      uri: `store://appgallery.huawei.com/app/detail?id=${appId}`
    };
    IntentUtil.jumpWant(want)
  }

  static jumpWant(want: Want) {
    global.getObject<common.UIAbilityContext>('ui_context').startAbility(want)
  }

  static jumpUrl(url: string) {
    if (!url) {
      return;
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      IntentUtil.jumpBrows(url);
      return;
    }
    const data: Record<string, string> = JSON.parse(url);
    if (data === undefined) {
      return;
    }
    const appId: string = data['appId'];
    if (appId !== undefined) {
      IntentUtil.jumpStore(appId);
      return;
    }

    //{"deviceId":"","bundleName":"cn.qincji.zerooneapp","abilityName":"EntryAbility"}
    const deviceId: string = data['deviceId'];
    const bundleName: string = data['bundleName'];
    const abilityName: string = data['abilityName'];

    if (bundleName !== undefined && abilityName !== undefined) {
      IntentUtil.jumpApp(deviceId, bundleName, abilityName);
      return;
    }

    //{"action":"ohos.want.action.search","entities":"entity.system.browsable","uri":"https://www.test.com:8080/query/student","type":"text/plain"}
    const action: string = data['action'];
    const entities: string = data['entities'];
    const uri: string = data['uri'];
    const type: string = data['type'];

    if (action !== undefined && entities !== undefined && uri !== undefined && type !== undefined) {
      IntentUtil.jumpAction(action, entities, uri, type);
      return;
    }
  }
}
