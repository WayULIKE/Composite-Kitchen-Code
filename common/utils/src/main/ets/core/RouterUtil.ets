/*
 * @Desc: 
 * @Author: qincji
 * @Date: 2024/5/28
 */

const TAG = 'RouterUtil';

export class RouterUtil {
  static navPathStack: NavPathStack = new NavPathStack();
  static routerStack: Array<string> = new Array();

  public static push(name: string, parm: object | undefined = undefined,
    callback: Callback<PopInfo> | undefined = undefined) {
    // RouterUtil.routerStack.push(name);
    RouterUtil.navPathStack.pushPathByName(name, parm, callback, true)
  }

  public static replace(name: string, parm: object | undefined = undefined) {
    RouterUtil.routerStack.pop();
    RouterUtil.routerStack.push(name);
    RouterUtil.navPathStack.replacePathByName(name, parm, true)
  }

  public static pop(result?: Object) {
    if (result !== undefined) {
      RouterUtil.navPathStack.pop(result, true)
    } else {
      RouterUtil.navPathStack.pop(true)
    }
  }

  public static finishPage(name: string) {
    RouterUtil.navPathStack.removeByName(name)
  }

  public static popHome() {
    RouterUtil.routerStack.length = 0;
    RouterUtil.navPathStack.clear()
  }
}
