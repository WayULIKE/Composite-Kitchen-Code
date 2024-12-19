import { BtnComp } from './BtnComp'
import { TextComp } from './TextComp'
import { TitleComp } from './TitleComp'
import { WebComp } from './WebComp'

@Component
export struct CoreDialog {
  @State lineStyleTop: AttributeModifier<LineAttribute> = {};
  @State lineStyleBottom: AttributeModifier<LineAttribute> = {};
  @State outBoxAttr: AttributeModifier<ColumnAttribute> = {};

  build() {
    Column() {
      //标题
      TitleComp()
      //分割线
      Line().lineStyle().attributeModifier(this.lineStyleTop)
      //内容
      WebComp()
      TextComp()
      //分割线
      Line().lineStyle().attributeModifier(this.lineStyleBottom)
      //按钮
      BtnComp()
    }
    .margin(40)
    .borderRadius(12)
    .backgroundColor(Color.White)
    .attributeModifier(this.outBoxAttr)
  }
}

@Extend(Line)
function lineStyle() {
  .backgroundColor('#E6E6E6')
  .width('100%')
  .height(px2vp(2))
}