// import { UIView, LinearGradient, Rect, Color, Point, Column } from '@harmonyos/hyperspace';


import { borderRadiuses } from '@ohos.arkui.node'
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { router } from '@kit.ArkUI';

import { CircleShape, EllipseShape, PathShape, RectShape } from "@ohos.arkui.shape";
import { UIContext } from '@ohos.arkui.UIContext';
import { LengthMetrics } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State selectedIndex: number = 1
  @State maskHeight: number = 58 / PREVIEWER_H_ZOOM;
  // @State maskHeight0: number = 58 / PREVIEWER_H_ZOOM;
  // @State maskHeight1: number = 58 / PREVIEWER_H_ZOOM;
  // @State maskHeight2: number = 58 / PREVIEWER_H_ZOOM;
  @State flag1: boolean = true
  @State searchText: string = ''
  uiContext: UIContext | undefined = undefined;
  @State text: string = ''
  @State positionInfo: CaretOffset = { index: 0, x: 0, y: 0 }
  @State passwordState: boolean = false
  TextInputController: TextInputController = new TextInputController()

  aboutToAppear() {
    this.uiContext = this.getUIContext?.();
  }

  private controller: TabsController = new TabsController()

  @Builder
  //todo:角度+圆角
  tabBuilder(BarIndex: number, name: string) {

    Column() {

      Text(name)
        .position({
          x: (this.selectedIndex === BarIndex) ? 90 / PREVIEWER_H_ZOOM : 57 / PREVIEWER_H_ZOOM,
          y: (this.selectedIndex === BarIndex) ? 0 / PREVIEWER_H_ZOOM : 8 / PREVIEWER_H_ZOOM
        })
        .fontSize(17)
        .animation({
          duration: 400,
          curve: Curve.Ease,
          iterations: 1,
          playMode: PlayMode.Normal
        })


      Stack() {
        Image($r(`app.media.IndexRect${BarIndex}`))
          .width(114 / PREVIEWER_H_ZOOM)
          .height(64 / PREVIEWER_V_ZOOM)
          .shadow({
            radius: 50,
            color: '#ffd4d4d4',
            offsetX: 0,
            offsetY: 0
          })
          .borderRadius(12)
          .interpolation(ImageInterpolation.High)
        Image($r(`app.media.IndexIcon${BarIndex}`))
          .width(68 / PREVIEWER_H_ZOOM)
          .height(122 / PREVIEWER_V_ZOOM)
          .position({
            x: (this.selectedIndex === BarIndex) ? 20 / PREVIEWER_H_ZOOM : 25 / PREVIEWER_H_ZOOM,
            y: (this.selectedIndex === BarIndex) ? -20 / PREVIEWER_H_ZOOM : 35 / PREVIEWER_H_ZOOM
          })

          .interpolation(ImageInterpolation.High)
          .rotate({ angle: (this.selectedIndex === BarIndex) ? -30 / PREVIEWER_H_ZOOM : 0 / PREVIEWER_H_ZOOM })
          .animation({
            duration: 500,
            curve: Curve.EaseInOut,
            iterations: 1,
            playMode: PlayMode.Alternate,
            expectedFrameRateRange: {
              min: 20,
              max: 120,
              expected: 60,
            }
          })


      }

    }.width('100%').justifyContent(FlexAlign.Center).height('100%')
    .maskShape(new Rect({
      width: 200 / PREVIEWER_H_ZOOM,
      // height: this.maskHeight
      height: 103 / PREVIEWER_H_ZOOM
    }).fill(Color.White))

  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: this.selectedIndex, controller: this.controller }) {
        TabContent() {

        }.tabBar(this.tabBuilder(0, '烹饪'))

        TabContent() {

          Column() {
            //标题
            Row({ space: 11 / PREVIEWER_V_ZOOM }) {
              //TODO:Search美化
              Search({ placeholder: '搜索食谱' })// .icon({
                //   src: $r('app.media.search_icon'), // 请确保search_icon在资源文件中
                //   size: { width: 24, height: 24 },
                //   color: Color.Black
                // })
                .onChange((value: string) => {
                  this.searchText = value
                })
                .width(233 / PREVIEWER_V_ZOOM)
                .height(47.64 / PREVIEWER_H_ZOOM)
                .backgroundColor(Color.White)
                .border({
                  color: Color.Black,
                  width: 3,
                  radius: 25
                })// .padding({ left: 15, right: 15 })
                .fontColor(Color.Black)
                .placeholderColor(Color.Gray)
                .textAlign(TextAlign.Start)
                .searchButton('搜索', {
                  fontSize: 16,
                  fontColor: Color.Black
                })
                .backgroundColor('#F5F5F5')// .margin({ left: 11 / PREVIEWER_V_ZOOM, right: 11 / PREVIEWER_V_ZOOM })
                .searchIcon({
                  size: 20,
                  src: $r('app.media.search_icon')
                })


              Button('我的食谱')
                .backgroundColor('#F5F5F5')
                .borderColor(Color.Black)
                .borderWidth(3)
                .borderRadius(20)// 修改圆角半径以匹配图片中的圆角效果
                .fontColor(Color.Black)
                .fontSize(16)
                .padding({
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5
                })
                .height(47.64 / PREVIEWER_H_ZOOM)


              Image($r('app.media.avatar'))
                .width(50 / PREVIEWER_V_ZOOM)
                .height(50 / PREVIEWER_V_ZOOM)
                .borderRadius(26 / PREVIEWER_V_ZOOM) // 将半径设置为宽度或高度的一半以创建一个圆形
              // .margin({ left: 11 / PREVIEWER_V_ZOOM, right: 11 / PREVIEWER_V_ZOOM })
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .width('100%')
            .height('14%')
            .backgroundColor('#F8FAF7')
            .shadow({
              radius: 60,
              color: '#ffc4c4c4',
              // color: Color.Black,
              offsetX: -10,
              offsetY: 20,
              fill: true

            })
            .backdropBlur(20)
            .borderRadius(30)

            Text('给你的菜起一个名字吧!')
              .width(570 / PREVIEWER_V_ZOOM)
              .height('35%')
              .position({ x: 18 / PREVIEWER_V_ZOOM, y: 10 / PREVIEWER_H_ZOOM })
              .fontSize(15)
            TextInput({ text: this.text, placeholder: '爆炒双脆', controller: this.TextInputController })
              .placeholderColor(Color.Black)
              .placeholderFont({ size: 22, weight: 400 })
              .caretColor(Color.Blue)
              .width('90%')
              .height(60)
              .position({ x: 14 / PREVIEWER_V_ZOOM, y: 185 / PREVIEWER_H_ZOOM })// .margin(20)
              .fontSize(22)
              .fontColor(Color.Black)// .inputFilter('[a-z]', (e) => {
                //   console.log(JSON.stringify(e))
                // })
              .onChange((value: string) => {
                this.text = value
              })
              .backgroundColor('#ECF4E5')
          }
          .width(428 / PREVIEWER_V_ZOOM)
          .height(926 / PREVIEWER_H_ZOOM)
          .backgroundColor(Color.White)

        }.tabBar(this.tabBuilder(1, '食谱'))

        TabContent() {
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
                    Image($r('app.media.IndexMineList0'))
                      .width(104 / PREVIEWER_V_ZOOM)
                      .height(47 / PREVIEWER_V_ZOOM)
                      .position({ x: 61.67 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })

                  }

                  Row() {
                    Image($r("app.media.IndexMineListIcon1"))
                      .width(43 / PREVIEWER_V_ZOOM)
                      .height(43 / PREVIEWER_V_ZOOM)
                      .position({ x: 223 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })
                    Image($r('app.media.IndexMineList0'))
                      .width(104 / PREVIEWER_V_ZOOM)
                      .height(47 / PREVIEWER_V_ZOOM)
                      .position({ x: 273 / PREVIEWER_V_ZOOM, y: 0 / PREVIEWER_H_ZOOM })

                  }

                  Row() {
                    Image($r("app.media.IndexMineListIcon1"))
                      .width(43 / PREVIEWER_V_ZOOM)
                      .height(43 / PREVIEWER_V_ZOOM)
                      .position({ x: 11.67 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })
                    Image($r('app.media.IndexMineList0'))
                      .width(104 / PREVIEWER_V_ZOOM)
                      .height(47 / PREVIEWER_V_ZOOM)
                      .position({ x: 61.67 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })

                  }

                  Row() {
                    Image($r("app.media.IndexMineListIcon1"))
                      .width(43 / PREVIEWER_V_ZOOM)
                      .height(43 / PREVIEWER_V_ZOOM)
                      .position({ x: 223 / PREVIEWER_V_ZOOM, y: 72 / PREVIEWER_H_ZOOM })
                    Image($r('app.media.IndexMineList0'))
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
                Image($r('app.media.IndexMIneImaButton1'))
                  .width(389 / PREVIEWER_V_ZOOM)
                  .height(170 / PREVIEWER_V_ZOOM)
                  .position({ x: 20 / PREVIEWER_V_ZOOM, y: 594 / PREVIEWER_H_ZOOM })


              }
              .width(428 / PREVIEWER_V_ZOOM)
              .height(926 / PREVIEWER_H_ZOOM)

            }

            // .position({ x: 0, y: 0 })

          }
          .width(428 / PREVIEWER_V_ZOOM)
          .height(926 / PREVIEWER_H_ZOOM)

          .backgroundColor(Color.White)
        }.tabBar(this.tabBuilder(2, '我的'))

      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .barHeight('15%')
      .animationDuration(400)
      .onChange((index: number) => {
        this.selectedIndex = index
      })
      .backgroundColor('#F1F3F5')
      .onTabBarClick((index: number) => {
        if (index == 0) {
          // router.push({ uri: 'pages/SelectRecipes' })
          router.pushUrl({
            url: 'pages/SelectRecipes',

          }, router.RouterMode.Standard, (err) => {
            if (err) {
              console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              return;
            }
            console.info('pushUrl success');
          })
        }

      })

    }
    .width(428 / PREVIEWER_V_ZOOM)
    .height(926 / PREVIEWER_H_ZOOM)
  }
}


/*中间页
 *
 Column() {
 Row() {
 Search()
 Image()
 Image()
 }
 .width('100%')
 .height('15%')

 Text()
 Row(){
 Text()
 Flex()
 }
 Row() {
 Text() {

 }

 Image() {

 }.height('12%')
 }
 .width('100%')

 Row(){
 Column(){

 }
 Column(){

 }
 }
 .width('80%')

 }
 .width(428 / PREVIEWER_V_ZOOM)
 .height(926 / PREVIEWER_H_ZOOM)
 */


/*
第一版：位置平移很奇怪
* Stack() {
        Image($r(`app.media.IndexRect${BarIndex}`))
          .width(114 / PREVIEWER_H_ZOOM)
          .height(64 / PREVIEWER_V_ZOOM)
          .shadow({
            radius: 50,
            color: '#ffd4d4d4',
            offsetX: 0,
            offsetY: 0
          })
          .borderRadius(12)
          .interpolation(ImageInterpolation.High)
        Image($r(`app.media.IndexIcon${BarIndex}`))
          .width(68 / PREVIEWER_H_ZOOM)
          .height(122 / PREVIEWER_V_ZOOM)
          .position({
            x: (this.selectedIndex === BarIndex) ? 20 / PREVIEWER_H_ZOOM : 25 / PREVIEWER_H_ZOOM,
            y: (this.selectedIndex === BarIndex) ? -20 / PREVIEWER_H_ZOOM : 35 / PREVIEWER_H_ZOOM
          })
          .maskShape(new Rect({
            width: 68 / PREVIEWER_H_ZOOM,
            height: (this.selectedIndex === BarIndex) ? 108 / PREVIEWER_H_ZOOM : 58 / PREVIEWER_H_ZOOM
          })
            .fill(Color.White))
          .interpolation(ImageInterpolation.High)
          .rotate({ angle: (this.selectedIndex === BarIndex) ? -30 / PREVIEWER_H_ZOOM : 0 / PREVIEWER_H_ZOOM })


      }
      .animation({
        duration: 1,
        curve: Curve.Linear,
        delay: 500,
        iterations: 1,
        playMode: PlayMode.Alternate,
        expectedFrameRateRange: {
          min: 20,
          max: 120,
          expected: 90,
        }
      })
 */

/*
 * 第二版：蒙版蹦来蹦去
 Stack() {
  Image($r(`app.media.IndexRect${BarIndex}`))
    .width(114 / PREVIEWER_H_ZOOM)
    .height(64 / PREVIEWER_V_ZOOM)
    .shadow({
      radius: 50,
      color: '#ffd4d4d4',
      offsetX: 0,
      offsetY: 0
    })
    .borderRadius(12)
    .interpolation(ImageInterpolation.High)
  Image($r(`app.media.IndexIcon${BarIndex}`))
    .width(68 / PREVIEWER_H_ZOOM)
    .height(122 / PREVIEWER_V_ZOOM)
    .position({
      x: (this.selectedIndex === BarIndex) ? 20 / PREVIEWER_H_ZOOM : 25 / PREVIEWER_H_ZOOM,
      y: (this.selectedIndex === BarIndex) ? -20 / PREVIEWER_H_ZOOM : 35 / PREVIEWER_H_ZOOM
    })
    .maskShape(new Rect({
      width: 68 / PREVIEWER_H_ZOOM,
      height: (this.selectedIndex === BarIndex) ? 108 / PREVIEWER_H_ZOOM : 58 / PREVIEWER_H_ZOOM
    })
      .fill(Color.White))
    .interpolation(ImageInterpolation.High)
    .rotate({ angle: (this.selectedIndex === BarIndex) ? -30 / PREVIEWER_H_ZOOM : 0 / PREVIEWER_H_ZOOM })
    .animation({
      duration: 500,
      curve: Curve.EaseInOut,
      iterations: 1,
      playMode: PlayMode.Alternate,
      expectedFrameRateRange: {
        min: 20,
        max: 120,
        expected: 60,
      }
    })

}
 */

/*
第三版迭代：函数不行
* if (index == 1) {
          animateTo({
            duration: 500,
            curve: Curve.EaseInOut,
            iterations: 1,
            playMode: PlayMode.Alternate,
          }, () => {
            this.maskHeight1 = 108 / PREVIEWER_H_ZOOM
            this.maskHeight2 = 58 / PREVIEWER_H_ZOOM
          })
        }
        if (index == 2) {
          animateTo(
            {
            duration: 500,
            curve: Curve.EaseInOut,
            iterations: 1,
            playMode: PlayMode.Alternate,
            expectedFrameRateRange: {
              min: 20,
              max: 120,
              expected: 60,
            }}
          , () => {
            this.maskHeight1 = 58 / PREVIEWER_H_ZOOM
            this.maskHeight2 = 108 / PREVIEWER_H_ZOOM
          })
        }
 */
