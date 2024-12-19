/*
 * @Desc: 首选项，数据持久化，缓存数据到本地（几K以下）
 * @Author: qincji
 * @Date: 2024/5/12
 */
import preferences from '@ohos.data.preferences'
import dataPreferences from '@ohos.data.preferences'
import { global } from './Global'
import { log } from './Log'

const TAG = 'Pref'
const PREF_OBJ_KEY = 'Pref'
const PREFERENCES_NAME = 'sleep-well-DB';

class Pref {
  public init(context: Context) {
    let preferencesFunc: Function = (() => {
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context, PREFERENCES_NAME);
      return preferences;
    });
    global.setObject(PREF_OBJ_KEY, preferencesFunc);
  }

  private getFunc() {
    const func = global.getObject<Function>(PREF_OBJ_KEY)
    if (func === undefined) {
      throw Error('请先调用init()！')
    }
    return func;
  }

  public put(key: string, value: number | string | boolean, notCover?: boolean) {
    let pref = this.getFunc();
    pref().then(async (preferences: dataPreferences.Preferences) => {
      if (typeof notCover === 'undefined' || notCover === false) { //需要覆盖
        await preferences.put(key, value);
        preferences.flush();
        return
      }
      preferences.has(key).then(async (isExist: boolean) => {
        log.i(TAG, 'preferences has changeFontSize is ' + isExist);
        if (!isExist) {
          await preferences.put(key, value);
          preferences.flush();
        }
      }).catch((err: Error) => {
        log.e(TAG, 'Has the value failed with err: ' + err);
      });
    }).catch((err: Error) => {
      log.e(TAG, 'Get the preferences failed, err: ' + err);
    });
  }

  public async get<T>(key: string, defValue: T): Promise<T> {
    let pref = this.getFunc();
    return await (await pref()).get(key, defValue) as Promise<T>;
  }

  public getCall<T>(key: string, defValue: T, callback: (data: T) => void) {
    let pref = this.getFunc();
    pref().then(async (pres: dataPreferences.Preferences) => {
      callback(pres.getSync(key, defValue as preferences.ValueType) as T);
    }).catch((err: Error) => {
      log.e(TAG, 'Get the preferences failed, err: ' + err);
      callback(defValue);
    });
  }

  public async delete(key: string) {
    let pref = this.getFunc();
    const preferences: dataPreferences.Preferences = await pref();
    let deleteValue = preferences.delete(key);
    deleteValue.then(() => {
      log.i(TAG, 'Succeeded in deleting the key appFontSize.');
    }).catch((err: Error) => {
      log.e(TAG, 'Failed to delete the key appFontSize. Cause: ' + err);
    });
  }
}

export let pref = new Pref();