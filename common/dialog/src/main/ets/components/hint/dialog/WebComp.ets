import { WebParm } from '../parms/WebParm'

/*
 * @Desc:中间网页显示的组件
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
@Component
export struct WebComp {
  @Consume webParm: WebParm | undefined

  build() {
    if (this.webParm !== undefined) {
      Web({ src: this.webParm.url, controller: this.webParm.controller })
        .padding(15)
        .width('100%')
        .constraintSize({ maxHeight: '80%' })
        .attributeModifier(this.webParm.attrModifier)
    }
  }
}