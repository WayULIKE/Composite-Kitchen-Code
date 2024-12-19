/*
 * @Desc:
 * @Author: qincji
 * @Date: 2024/6/12
 */
import { HintParm } from '@common/dialog/Index';
import { global, log, RouterUtil } from '@common/utils';
import { window } from '@kit.ArkUI';

const TAG = 'HomePage';

@Component
export struct HomePage {
  @State value: string = '';
  // @StorageProp('statusHeight') statusHeight: number = 0;
  // @StorageProp('bottomHeight') bottomHeight: number = 0;
  //
  // aboutToAppear(): void {
  //   log.i(TAG, `获取系统状态栏和导航栏高度: ${this.statusHeight} | ${this.bottomHeight}`)
  // }

  build() {
    Column() {

      Button('CreView')
        .onClick(() => {
          const parm: String = '随便传就行CrePage';
          RouterUtil.push('CreView', parm, async (info: PopInfo) => {
            this.value = JSON.stringify(info.result)
            console.log(this.value + '?????')
          })
        })
    }
    .width('100%')
    .height('100%')
  }
}
