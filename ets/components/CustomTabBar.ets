import { ConfigurationConstant } from '@kit.AbilityKit';
import { TabBarData, TabBarType, TabsInfo } from '../model/TabBarModel';
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';

@Component
export struct CustomTabBar {
  @Link currentIndex: number;
  @StorageProp('MineCurrentStep') MineCurrentStep: string = 'MineView';

  aboutToAppear() {
    this.currentIndex = AppStorage.get('currentIndex') as number;
  }

  onChange(index: number): void {
    this.currentIndex = index;
  }

  build() {
    Flex() {
      ForEach(TabsInfo, (item: TabBarData) => {
        TabItem({
          index: item.id,
          selectedIndex: this.currentIndex,
          onChange: (index: number) => this.onChange(index)
        })
      }, (item: TabBarData) => item.id.toString())

    }

    .borderRadius(this.MineCurrentStep === 'MyIngredientsView' ?{
      topLeft: 0,
      topRight: 0,
      bottomLeft: 0,
      bottomRight: 0
    }:{
      topLeft: 30,
      topRight: 30,
      bottomLeft: 0,
      bottomRight: 0
    })
    .backgroundColor(this.MineCurrentStep === 'MyIngredientsView' ? '#9FBCDD' : '#FCFCFC')
    .shadow({
      radius: 6,
      color: '#ffc4c4c4',
      offsetX: 0,
      offsetY: 0,
      fill: true

    })
  }
}

@Component
struct TabItem {
  @Prop index: number
  @Prop selectedIndex: number;
  @State showAnimation: boolean = false;
  onChange: (index: number) => void = () => {
  };

  build() {

    Column() {

      Text(TabsInfo[this.index].title)
        .offset(
          (this.index === this.selectedIndex) ?
          TabsInfo[this.index].TextActivePosition : TabsInfo[this.index].TextDefaultPosition,
        )
        .fontSize(17)
        .animation({
          duration: 500,
          curve: Curve.Ease,
          iterations: 1,
          playMode: PlayMode.Normal
        })
        .fontColor(TabsInfo[this.index].TextColor)


      Stack() {
        Image(TabsInfo[this.index].Rect)
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
        Image(TabsInfo[this.index].Icon)
          .width(68 / PREVIEWER_H_ZOOM)
          .height(122 / PREVIEWER_V_ZOOM)
          .offset(
            (this.index === this.selectedIndex) ?
            TabsInfo[this.index].activePosition : TabsInfo[this.index].defaultPosition,
          )

          .interpolation(ImageInterpolation.High)
          .rotate((this.selectedIndex === this.index) ?
          TabsInfo[this.index].activeRotate : TabsInfo[this.index].defaultRotate)
          .animation({
            duration: 300,
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

    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)

    .onClick(() => {
      if (this.index == 0) {

        AppStorage.setOrCreate("isChooseRecipeView", true)
        AppStorage.setOrCreate('MineCurrentStep','MineView')
      }
      if (this.index == 1) {
        AppStorage.setOrCreate('currentStep','BeginView')
        AppStorage.setOrCreate('MineCurrentStep','MineView')

      }
      if (this.index == 2) {
        AppStorage.setOrCreate('MineCurrentStep','MineView')
        AppStorage.setOrCreate('MineHaveSearchBar',false)
      }
      if (this.selectedIndex !== this.index) {
        this.showAnimation = true;
        console.log('isChooseRecipeView?')
        this.onChange(this.index);
        setTimeout(() => {
          this.showAnimation = false;
        }, 300)
      }
    })
    .maskShape(new Rect({
      width: 200 / PREVIEWER_H_ZOOM,
      // height: this.maskHeight
      height: 116 / PREVIEWER_H_ZOOM
    }).fill(Color.White))

  }
}