import { TitleParm } from '../parms/TitleParm'

/*
 * @Desc: 弹框标题的显示组件
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
@Preview
@Component
export struct TitleComp {
  @Consume titleParm: TitleParm | undefined

  build() {
    if (this.titleParm !== undefined) {
      Text(this.titleParm.title)
        .fontSize(14)
        .padding({ top: 20, bottom: 15 })
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .fontColor('#666666')
        .width('100%')
        .attributeModifier(this.titleParm.attrModifier)
    }
  }
}