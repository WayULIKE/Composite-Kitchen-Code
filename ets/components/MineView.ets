import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { LengthMetrics } from '@kit.ArkUI';
import { cloudCommon } from '@kit.CloudFoundationKit';

@Preview
@Component
export struct MineView {
  @State searchText: string = ''

  build() {
    Column() {
      Stack() {
        //背景
        Image($r('app.media.IndexMineBack0'))
          .width(570 / PREVIEWER_V_ZOOM)
          .height('35%')
          .position({ x: -70 / PREVIEWER_V_ZOOM, y: -40 / PREVIEWER_H_ZOOM })

        Image($r('app.media.IndexMineBack1'))
          .position({ x: 0 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
          .width('100%')
          .height('30%')
        Column({ space: 2 }) {
          //用户信息
          Row({ space: 10 }) {
            Image($r('app.media.avatar'))
              .width(121 / PREVIEWER_V_ZOOM)
              .height(121 / PREVIEWER_H_ZOOM)
            Blank()
              .width(16)
            Column({ space: 6 }) {
              Text('我爱做饭')

                .fontSize(22)
              Text('ID :327948')
                .fontSize(10)
                .fontColor(Color.Gray)
              Text('原创14食谐')
                .fontSize(14)
                .fontColor(Color.Gray)
              Text('被收藏133次')
                .fontSize(14)
                .fontColor(Color.Gray)
            }
            .width('40%')
            .alignItems(HorizontalAlign.Start)

          }
          .height('30%')
          .padding({ top: 10 })
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          //列表
          Column({ space: 12 }) {
            Row({ space: 8 }) {
              Row({ space: 6 }) {
                Image($r("app.media.IndexMineListIcon1"))
                  .width(43 / PREVIEWER_V_ZOOM)
                  .height(43 / PREVIEWER_V_ZOOM)
                Button('我的口味')
                  .backgroundColor(Color.White)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Normal)
                  .onClick((event: ClickEvent) => {
                    console.log("why!!!1");
                  })
                  .width(104 / PREVIEWER_V_ZOOM)
                  .height(47 / PREVIEWER_V_ZOOM)
              }

              Row({ space: 6 }) {
                Image($r("app.media.IndexMineListIcon2"))
                  .width(43 / PREVIEWER_V_ZOOM)
                  .height(43 / PREVIEWER_V_ZOOM)
                // Image($r('app.media.IndexMineList0'))
                //   .width(104 / PREVIEWER_V_ZOOM)
                //   .height(47 / PREVIEWER_V_ZOOM)
                //   .position({ x: 273 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
                Button('我的收藏')
                  .backgroundColor(Color.White)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Normal)
                  .onClick((event: ClickEvent) => {
                    console.log("why!!!2");

                  })
                  .width(104 / PREVIEWER_V_ZOOM)
                  .height(47 / PREVIEWER_V_ZOOM)

              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)



            Row({ space: 8 }) {
              Row({ space: 6 }) {
                Image($r('app.media.IndexMineListIcon3'))
                  .width(43 / PREVIEWER_V_ZOOM)
                  .height(43 / PREVIEWER_V_ZOOM)
                Button('我的食谱')
                  .backgroundColor(Color.White)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Normal)
                  .onClick(()=>{
                    AppStorage.setOrCreate('MineCurrentStep', 'MyRecipe')
                    AppStorage.setOrCreate('MineHaveSearchBar', true)
                  })
                  .width(104 / PREVIEWER_V_ZOOM)
                  .height(47 / PREVIEWER_V_ZOOM)

              }


              Row({ space: 6 }) {
                Image($r('app.media.IndexMineListIcon4'))
                  .width(43 / PREVIEWER_V_ZOOM)
                  .height(43 / PREVIEWER_V_ZOOM)
                Button('食谱清单')
                  .backgroundColor(Color.White)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Normal)
                  .onClick((event: ClickEvent) => {
                    console.log("why!!!4");

                  })
                  .width(104 / PREVIEWER_V_ZOOM)
                  .height(47 / PREVIEWER_V_ZOOM)

              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)

          }
          .width('100%')
          .height('auto')

          Image($r('app.media.IndexMIneImaButton0'))
            .width(387 / PREVIEWER_V_ZOOM)
            .height(230 / PREVIEWER_V_ZOOM)
            .onClick(() => {
              AppStorage.setOrCreate('MineCurrentStep', 'MyIngredientsView')
              AppStorage.setOrCreate('MineHaveSearchBar', true)
            })
            .width('92%')
            .objectFit(ImageFit.Auto)
          Image($r('app.media.IndexMIneImaButton1'))
            .width(389 / PREVIEWER_V_ZOOM)
            .height(170 / PREVIEWER_V_ZOOM)
            .onClick(() => {
              AppStorage.setOrCreate('MineCurrentStep', 'HealthRecommendationView')
              AppStorage.setOrCreate('MineHaveSearchBar', true)
            })

        }
        .width('100%')
        .height('100%')

      }

    }
    .width('100%')
    .height('100%')

    .backgroundColor(Color.White)

  }
}

/**
 Column() {
 Stack() {
 //背景
 Image($r('app.media.IndexMineBack0'))
 .width(570 / PREVIEWER_V_ZOOM)
 .height('35%')
 .position({ x: -70 / PREVIEWER_V_ZOOM, y: -40 / PREVIEWER_H_ZOOM })

 Image($r('app.media.IndexMineBack1'))
 .position({ x: 0 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
 .width('100%')
 .height('30%')
 Column() {
 //用户信息
 Row() {
 Image($r('app.media.avatar'))
 .position({ x: 28.6 / PREVIEWER_V_ZOOM, y: 65.3 / PREVIEWER_H_ZOOM })
 .width(121 / PREVIEWER_V_ZOOM)
 .height(121 / PREVIEWER_H_ZOOM)
 Text('我爱做饭')
 .position({ x: 190 / PREVIEWER_V_ZOOM, y: 65.3 / PREVIEWER_H_ZOOM })
 .fontSize(22)
 Text('ID :327948')
 .position({ x: 190 / PREVIEWER_V_ZOOM, y: 95.3 / PREVIEWER_H_ZOOM })
 .fontSize(10)
 .fontColor(Color.Gray)
 Text('原创14食谐')
 .position({ x: 190 / PREVIEWER_V_ZOOM, y: 125.3 / PREVIEWER_H_ZOOM })
 .position({ x: 190 / PREVIEWER_V_ZOOM, y: 120.3 / PREVIEWER_H_ZOOM })
 .fontSize(14)
 .fontColor(Color.Gray)
 Text('被收藏133次')
 .position({ x: 190 / PREVIEWER_V_ZOOM, y: 135.3 / PREVIEWER_H_ZOOM })
 .fontSize(14)
 .fontColor(Color.Gray)
 }

 //列表
 Row() {
 Row() {
 Image($r("app.media.IndexMineListIcon1"))
 .width(43 / PREVIEWER_V_ZOOM)
 .height(43 / PREVIEWER_V_ZOOM)
 .position({ x: 11.67 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
 // Image($r('app.media.IndexMineList0'))
 //   .width(104 / PREVIEWER_V_ZOOM)
 //   .height(47 / PREVIEWER_V_ZOOM)
 Button('我的口味')
 .backgroundColor(Color.White)
 .shadow(ShadowStyle.OUTER_DEFAULT_XS)
 .fontColor(Color.Black)
 .fontWeight(FontWeight.Normal)
 .onClick((event: ClickEvent) => {
 console.log("why!!!1");
 })
 .position({ x: 61.67 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
 .width(104 / PREVIEWER_V_ZOOM)
 .height(47 / PREVIEWER_V_ZOOM)
 }

 Row() {
 Image($r("app.media.IndexMineListIcon2"))
 .width(43 / PREVIEWER_V_ZOOM)
 .height(43 / PREVIEWER_V_ZOOM)
 .position({ x: 223 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
 // Image($r('app.media.IndexMineList0'))
 //   .width(104 / PREVIEWER_V_ZOOM)
 //   .height(47 / PREVIEWER_V_ZOOM)
 //   .position({ x: 273 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
 Button('我的收藏')
 .backgroundColor(Color.White)
 .shadow(ShadowStyle.OUTER_DEFAULT_XS)
 .fontColor(Color.Black)
 .fontWeight(FontWeight.Normal)
 .onClick((event: ClickEvent) => {
 console.log("why!!!2");

 })
 .width(104 / PREVIEWER_V_ZOOM)
 .height(47 / PREVIEWER_V_ZOOM)
 .position({ x: 273 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })

 }

 Row() {
 Image($r('app.media.IndexMineListIcon3'))
 .width(43 / PREVIEWER_V_ZOOM)
 .height(43 / PREVIEWER_V_ZOOM)
 .position({ x: 11.67 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })
 // Image($r('app.media.IndexMineList0'))
 Button('我的食谱')
 .backgroundColor(Color.White)
 .shadow(ShadowStyle.OUTER_DEFAULT_XS)
 .fontColor(Color.Black)
 .fontWeight(FontWeight.Normal)
 .onClick((event: ClickEvent) => {
 console.log("why!!!3");

 })
 .width(104 / PREVIEWER_V_ZOOM)
 .height(47 / PREVIEWER_V_ZOOM)
 .position({ x: 61.67 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })

 }

 Row() {
 Image($r('app.media.IndexMineListIcon4'))
 .width(43 / PREVIEWER_V_ZOOM)
 .height(43 / PREVIEWER_V_ZOOM)
 .position({ x: 223 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })
 Button('食谱清单')
 .backgroundColor(Color.White)
 .shadow(ShadowStyle.OUTER_DEFAULT_XS)
 .fontColor(Color.Black)
 .fontWeight(FontWeight.Normal)
 .onClick((event: ClickEvent) => {
 console.log("why!!!4");

 })
 .width(104 / PREVIEWER_V_ZOOM)
 .height(47 / PREVIEWER_V_ZOOM)
 .position({ x: 273 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })

 }

 }
 .position({ x: 10 / PREVIEWER_V_ZOOM, y: 250 / PREVIEWER_H_ZOOM })
 // .borderWidth(1)
 .width(428 / PREVIEWER_V_ZOOM)
 .height(129 / PREVIEWER_V_ZOOM)

 Image($r('app.media.IndexMIneImaButton0'))
 .width(387 / PREVIEWER_V_ZOOM)
 .height(230 / PREVIEWER_V_ZOOM)
 .position({ x: 20 / PREVIEWER_V_ZOOM, y: 391 / PREVIEWER_H_ZOOM })
 .onClick(() => {
 AppStorage.setOrCreate('MineCurrentStep', 'MyIngredientsView')
 AppStorage.setOrCreate('MineHaveSearchBar',true)
 })
 Image($r('app.media.IndexMIneImaButton1'))
 .width(389 / PREVIEWER_V_ZOOM)
 .height(170 / PREVIEWER_V_ZOOM)
 .position({ x: 20 / PREVIEWER_V_ZOOM, y: 594 / PREVIEWER_H_ZOOM })
 .onClick(() => {
 AppStorage.setOrCreate('MineCurrentStep', 'HealthRecommendationView')
 AppStorage.setOrCreate('MineHaveSearchBar',true)
 })


 }
 .width(428 / PREVIEWER_V_ZOOM)
 .height(926 / PREVIEWER_H_ZOOM)

 }

 // .position({ x: 0, y: 0 })

 }
 .width(428 / PREVIEWER_V_ZOOM)
 .height(926 / PREVIEWER_H_ZOOM)

 .backgroundColor(Color.White)
 */


