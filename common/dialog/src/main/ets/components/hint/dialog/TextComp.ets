import { TextParm } from '../parms/TextParm'


/*
 * @Desc: 中间文本显示的组件
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
@Component
export struct TextComp {
  @Consume textParm: TextParm | undefined

  build() {
    if (this.textParm !== undefined) {
      Scroll() {
        Text(this.textParm.content)
          .fontSize(18)
          .padding(15)
          .textAlign(TextAlign.Center)
          .fontColor('#2c2c2c')
          .attributeModifier(this.textParm.attrModifier)
      }
      .width('100%')
      .constraintSize({ maxHeight: '80%' })
    }
  }
}