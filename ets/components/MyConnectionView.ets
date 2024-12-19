import { LengthMetrics } from "@kit.ArkUI"
import { PREVIEWER_H_ZOOM } from "../common/constants/CommonConstants"

@Preview
@Component
export struct MyConnectionView {
  @State tomatoImages: ResourceStr[] =
    [$r('app.media.backButton'), $r('app.media.T1'), $r('app.media.T2'), $r('app.media.T3'), $r('app.media.T4')]
  @State tomatoStrings: string[] = ["上一页","番茄炒蛋", "番茄鸡蛋汤", "烤鸡蛋配樱桃番茄", "番茄鸡蛋"]

  build() {
    Column({ space: 10 }) {
      Row({space:10}) {
        Image($r('app.media.Tomato'))
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(Color.White)
        Image($r('app.media.Egg'))
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(Color.White)
      }
      .backgroundColor('#E7F6DC')
      .borderRadius(30)
      .shadow(ShadowStyle.OUTER_DEFAULT_XS)
      .height(80)
      .width('80%')
      .padding(10)

      Text('合成食谱')
        .fontSize(25)
      Flex({
        wrap: FlexWrap.Wrap,
        space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) }
      }) { // 子组件多行布局
        ForEach(this.tomatoImages, (item: ResourceStr, index: number) => {
          Column({space:6}) {
            if (index==0) {
              Row(){
                Image(item)
                  .width(40)
                  .height(40)
                  .borderRadius(20)
                  .backgroundColor(Color.White)
                  .objectFit(ImageFit.Auto)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .onClick(() => {
                    AppStorage.setOrCreate('MineCurrentStep', 'MyIngredientsView')
                    AppStorage.setOrCreate('MineHaveSearchBar', true)
                  })
              }
              .width(80)
              .height(80)
              .justifyContent(FlexAlign.Center)
              .padding(10)


            }else {
              Image(item)
                .width(100)
                .height(100)
            }

            Text(this.tomatoStrings[index])
              .maxLines(2)
              .width(100)
              .textAlign(TextAlign.Center)
          }
          .alignItems(HorizontalAlign.Center)
        })

      }
      .width('90%')
      // .position({ x: 31 / PREVIEWER_V_ZOOM, y: 242 / PREVIEWER_H_ZOOM })
      .margin({ top: 8 })

    }
    .alignItems(HorizontalAlign.Start)
  }
}