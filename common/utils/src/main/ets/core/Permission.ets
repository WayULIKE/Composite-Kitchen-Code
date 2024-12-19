/*
 * @Desc: 权限管理工具
 * @Author: qincji
 * @Date: 2024/4/20
 */
import { abilityAccessCtrl, bundleManager, common, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { log } from './Log';

const TAG = 'Permission';

class Permission {
  /**
   * 检测是否已授权
   * @param {Permissions} permissionName 检测授权的权限名
   * @returns {boolean} 检测结果
   */
  async checkPermission(permissionName: Permissions): Promise<boolean> {
    // 检测用户是否已经授权
    const grantStatus: abilityAccessCtrl.GrantStatus = await this.reqCurGrantStatus(permissionName);
    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 用户之前已授权，可以直接访问目标操作
      return true;
    }

    // 用户未授权
    return false;
  }

  /**
   * 检测权限状态
   * @param {Permissions} permission 检测授权的权限名
   * @returns {Promise<abilityAccessCtrl.GrantStatus>} 权限状态
   */
  async reqCurGrantStatus(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    try {
      const bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      const appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      log.i(TAG, `Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`)
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  }

  /**
   * 向用户申请授权
   * @param {Permissions} permissionName 申请授权的权限名
   * @returns {boolean} 申请授权结果
   */
  async requestPermission(permissionName: Permissions): Promise<boolean> {
    // 向用户申请授权
    let context = getContext() as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();
    let grantStatusArr = await atManager.requestPermissionsFromUser(context, [permissionName]);
    grantStatusArr.permissions
    const grantStatus = grantStatusArr.authResults[0];
    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 用户授权，可以继续访问目标操作
      return true;
    }

    return false;
  }

  request(permissionName: Permissions, onAgree?: (isAgree: boolean) => void) {
    // 向用户申请授权
    let context = getContext() as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();

    atManager.requestPermissionsFromUser(context, [permissionName]).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          onAgree?.(true)
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          onAgree?.(false)
          return;
        }
      }
      // 授权成功
    }).catch((err: BusinessError) => {
      log.e(TAG, `Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }
}

export let permission = new Permission();