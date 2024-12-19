/*
 * @Desc: 全局内存对象缓存工具类，比如：保存 Function 、Context等
 * @Author: qincji
 * @Date: 2024/5/25
 */
import { systemDateTime } from '@kit.BasicServicesKit';
import { log } from './Log';

const TAG = 'Global';

class Global {
  private _objects = new Map<string, Object>();
  private lastClickTime: number = 0;

  public setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }

  public getObject<T>(value: string): T {
    return this._objects.get(value) as T;
  }

  /**
   * 判断是否是快速点击
   * @returns
   */
  public isQuickClick(): boolean {
    const curTime = systemDateTime.getTime();
    if (curTime - this.lastClickTime > 600) {
      this.lastClickTime = curTime;
      return false;
    }
    log.i(TAG, '点击过快了');
    return true;
  }

  /**
   * 阻断快速点击代理，比使用{isQuickClick}更加简洁
   */
  public blockQuickClick(onClick: () => void): () => void {
    return () => {
      if (this.isQuickClick()) {
        return
      }
      onClick();
    }
  }
}

export let global = new Global()