/*
 * @Desc: 沉浸式状态栏和标题栏的设置
 * @Author: qincji
 * @Date: 2024/6/23
 */
@Component
export struct Header {
  @Require @Prop title: string | Resource; //标题
  onKeyBack?: () => void; //监听返回事件，如果不设置则隐藏返回键
  @BuilderParam rightLayout?: () => void; //自定义的右边布局
  titleBarHeight: Length = 45; //标题栏高度
  titleSize: number | string | Resource = '18fp'; //标题字体大小
  titleAttrModifier: AttributeModifier<TextAttribute> = {}; //标题控件的样式
  bgTopColor: ResourceColor = '#74C678'; //状态栏和标题栏背景 顶部颜色
  bgBottomColor: ResourceColor = '#266B29'; //状态栏和标题栏背景 底部颜色
  titleColor: ResourceColor = Color.White; //标题字体颜色
  @StorageProp('statusHeight') statusHeight: number = 0; //状态栏高度

  build() {
    Stack() {
      RelativeContainer() {
        Text(this.title)
          .fontSize(this.titleSize)
          .width('50%')
          .height('100%')
          .fontColor(this.titleColor)
          .fontWeight(FontWeight.Medium)
          .ellipsisMode(EllipsisMode.END)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .textAlign(TextAlign.Center)
          .alignRules({
            middle: { anchor: "__container__", align: HorizontalAlign.Center },
          })
          .id("i1")
          .attributeModifier(this.titleAttrModifier)

        if (this.onKeyBack) {
          Image($r('app.media.ic_back'))
            .height('100%')
            .padding({
              left: 16,
              top: 11,
              bottom: 11,
              right: 11
            })
            .fillColor(this.titleColor)
            .objectFit(ImageFit.Contain)
            .alignRules({
              left: { anchor: "__container__", align: HorizontalAlign.Start },
            })
            .id("i2")
            .onClick(() => {
              this.onKeyBack?.()
            })
        }
        if (this.rightLayout) {
          Row() {
            this.rightLayout?.()
          }
          .height('100%')
          .justifyContent(FlexAlign.End)
          .alignRules({
            right: { anchor: "__container__", align: HorizontalAlign.End },
          })
          .id("i3")
        }
      }
      .width('100%')
      .height(this.titleBarHeight)
    }
    .width('100%')
    .padding({ top: this.statusHeight })
    .backgroundColor(this.bgTopColor)
    .linearGradient({
      angle: 0, // 0点方向顺时针旋转为正向角度，线性渐变起始角度的默认值为180°
      colors: [
        [this.bgTopColor, 0.0], // 颜色断点1的颜色和比重，对应组件在180°方向上的起始位置
        [this.bgBottomColor, 1.0],// 颜色断点2的颜色和比重，对应组件在180°方向上的终点位置
      ]
    })

  }
}