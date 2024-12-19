import { DetailedStep, Flavor, Food, Recipe, Seasoning, Step } from '../model/RecipeModel';
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { LengthMetrics } from '@kit.ArkUI';
import { text } from '@kit.ArkGraphics2D';
import recipeModel from '../viewmodel/RecipeViewModel';
import { CameraUtil } from '../common/utils/CameraUtil';
import { common } from '@kit.AbilityKit';

import { photoPickerGetUri } from '../common/utils/GetPhotoAlbumUtil';


@Component
export struct SecondCreView {
  // @StorageProp('foods') foods: Food[] = [];
  // @StorageProp('seasonings') seasonings: Seasoning[] = [];
  // @StorageProp('flavorsData') flavorsData: Flavor[] = [];
  // @StorageProp('steps') steps: Step[] = [];
  // @StorageProp('detailedSteps') detailedSteps: DetailedStep[] = [];
  // @StorageProp('recipes') recipes: Recipe[] = [];
  // @StorageProp('doneCount') doneCount: number = 0;
  // @State isFirst: boolean = true
  @State haveMore: boolean = false;
  @State offsetX: number = 0;
  // @State offsetY: number = 0;
  @State positionX: number = 0;
  // @State positionY: number = 0;
  @StorageProp('nowId') nowId: string = '';
  @State text: string = recipeModel.getRecipeNameById(this.nowId)
  @State foods: Food[] = recipeModel.getFoodsByRecipeId(this.nowId) as Food[]
  @State seasonings: Seasoning[] = recipeModel.getSeasoningsByRecipeId(this.nowId) as Seasoning[]
  @State flavorsData: Flavor[] = recipeModel.getFlavorByRecipeId(this.nowId) as Flavor[]
  @State steps: Step[] = recipeModel.getStepsByRecipeId(this.nowId) as Step[]
  @State detailedSteps: DetailedStep[] = recipeModel.getDetailedStepsById(this.nowId, 0) as DetailedStep[]
  private swiperController: SwiperController = new SwiperController()

  aboutToAppear(): void {
    // this.foods = AppStorage.get("foods") as Food[];
    // this.seasonings = AppStorage.get("seasonings") as Seasoning[];
    // this.flavorsData = AppStorage.get("flavorsData") as Flavor[];
    // this.steps = AppStorage.get("steps") as Step[];
    // this.detailedSteps = AppStorage.get("detailedSteps") as DetailedStep[];

    // this.recipes = AppStorage.get("recipes") as Recipe[];
    // this.doneCount = AppStorage.get("doneCount") as number;
    //
    // this.foods = this.recipes[this.doneCount].foods
    // this.seasonings = this.recipes[this.doneCount].seasonings
    // this.flavorsData = this.recipes[this.doneCount].flavor
    // this.steps = this.recipes[this.doneCount].steps
    // this.detailedSteps = this.recipes[this.doneCount].steps[0].detailedSteps


    // if (this.isFirst) {
    //
    //   this.detailedSteps.push(new DetailedStep('', ''));
    //
    //   this.steps.push(new Step('', this.detailedSteps));
    //
    //   this.isFirst = false
    // }

  }

  aboutToDisappear() {
    // AppStorage.setOrCreate("steps", this.steps)
    // AppStorage.setOrCreate("detailedSteps", this.detailedSteps)
    // AppStorage.setOrCreate("recipes", this.recipes)

  }

  build() {

    Column({ space: 13 }) {

      Text(this.text)
        .padding({
          top: '8vp',
          right: '16vp',
          bottom: '8vp',
          left: '16vp'
        })
        .width('93%')
        .height(60)// .position({ x: 14 / PREVIEWER_V_ZOOM, y: 185 / PREVIEWER_H_ZOOM })// .margin(20)
        .fontSize(22)
        .fontColor(Color.Black)
        .backgroundColor('#ECF4E5')
        .shadow(ShadowStyle.OUTER_FLOATING_SM)
        .borderRadius(12)
      Row() {

        Column({ space: 11 }) {
          Text('食材')
            .fontSize(20)
          Row() {
            Flex({
              wrap: FlexWrap.NoWrap,
              space: {
                main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM),
                cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM)
              }
            }) {
              ForEach(this.foods, (item: Food) => {
                Row({ space: 6 }) {
                  Text(item.name)
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .fontSize(15)
                    .width('auto')
                    .height(40)
                    .backgroundColor(Color.White)
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .borderRadius(10)
                    .align(Alignment.Center)
                    .padding({
                      top: '4vp',
                      right: '4vp',
                      bottom: '4vp',
                      left: '4vp'
                    })
                }
              })
              Text('...')
                .align(Alignment.Bottom)

            }

          }


          Row() {
            Image($r('app.media.SeasoningImage'))
              .width(30)
              .opacity(10)
            Flex({
              wrap: FlexWrap.NoWrap,
              space: {
                main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM),
                cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM)
              }
            }) {
              ForEach(this.flavorsData, (item: Flavor) => {
                Row({ space: 6 }) {
                  Text('\t' + item.name + '\t')
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .fontSize(15)
                    .width('auto')
                    .height(40)
                    .backgroundColor(Color.White)
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .borderRadius(10)
                    .align(Alignment.Center)
                }
              })
            }
          }

        }
        .width('50%')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 11 }) {
          Text('调料')
            .fontSize(20)
          Column() {
            Flex({
              wrap: FlexWrap.Wrap,
              space: {
                main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM),
                cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM)
              }
            }) {
              ForEach(this.seasonings, (item: Seasoning) => {
                Row({ space: 6 }) {
                  Text('\t' + item.name + '\t')
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .fontSize(15)
                    .width('auto')
                    .height(40)
                    .backgroundColor(Color.White)
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .borderRadius(10)
                    .align(Alignment.Center)
                    .padding({
                      top: '4vp',
                      right: '4vp',
                      bottom: '4vp',
                      left: '4vp'
                    })
                }
              })
              Text('...')
                .padding({ top: 6 })
            }

          }

        }
        .width('50%')
        .alignItems(HorizontalAlign.Start)

      }
      .width('93%')
      .alignItems(VerticalAlign.Top)

      Column({ space: 8 }) {
        Text('详细步骤')
          .fontSize(32)
        Column({ space: 11 }) {
          Text('输入步骤名称')
            .fontSize(14)
            .fontColor(Color.Black)
            .width('auto')

          // TextInput({ placeholder: '例:处理食材', text: this.steps[0].name })
          TextInput({ placeholder: '例:处理食材', text: this.steps[0].name })
            .placeholderColor(Color.Black)
            .backgroundColor('#FCEBE4')
            .onChange((value) => {
              this.steps[0].name = value
            })
          Row({ space: 11 }) {
            Text('输入详细内容')
              .fontSize(12)
              .fontColor(Color.Black)
          }


          Row() {

            Swiper(this.swiperController) {
              ForEach(this.detailedSteps, (item: DetailedStep) => {
                Column() {
                  // TextInput({ placeholder: '在这里输入详细的步骤', text: this.steps[0].detailedSteps[SmallIndex].detailedStepContent })
                  TextInput({ placeholder: '在这里输入详细的步骤', text: item.content })
                    .height('auto')
                    .fontSize(14)
                    .align(Alignment.TopStart)
                    .backgroundColor('#F6FFEE')
                    .onChange((value) => {
                      item.content = value as string;
                    })
                  Row({ space: 6 }) {

                    if (item.recipeImages) {
                      ForEach(item.recipeImages, (item: ResourceStr) => {
                        Image(item)
                          .borderRadius(12)
                          .width(70)
                          .height(70)
                          .borderStyle(BorderStyle.Dashed)
                          .borderWidth(2)
                          .borderColor('#C8D1C1')
                      })

                    }

                    Image($r('app.media.CreImageButton'))
                      .borderRadius(12)
                      .width(70)
                      .height(70)
                      .borderStyle(BorderStyle.Dashed)
                      .borderWidth(2)
                      .borderColor('#C8D1C1')
                      .onClick(async () => {
                        let context = getContext(this) as common.Context;
                        let cameraUtil = new CameraUtil(context);
                        let photoUri = await cameraUtil.takePhoto() as string
                        item.recipeImages?.push(photoUri)
                        this.detailedSteps = recipeModel.getDetailedStepsById(this.nowId, 0) as DetailedStep[]
                      })


                  }
                  .justifyContent(FlexAlign.Start)
                  .width('80%')

                }
              })
            }
            .width('100%')
            .height(160)
            .backgroundColor('#F6FFEE')
            .cachedCount(3)
            .index(0)
            .autoPlay(false)
            .indicatorInteractive(true)
            .duration(1000)
            .itemSpace(0)
            .indicator( // 设置圆点导航点样式
              new DotIndicator()
                .itemWidth(15)
                .itemHeight(8)
                .selectedItemWidth(25)
                .selectedItemHeight(8)
                .color('#07A810')
                .selectedColor('#07A810'))
            .displayArrow({
              // 设置导航点箭头样式
              showBackground: true,
              isSidebarMiddle: true,
              backgroundSize: 24,
              backgroundColor: Color.White,
              arrowSize: 18,
              arrowColor: '#49FD3D'
            }, false)
            .curve(Curve.Linear)
            .disableSwipe(true)
            .borderRadius(30)

          }
          .borderRadius(30)
          .shadow(ShadowStyle.OUTER_DEFAULT_XS)

          .translate({ x: this.offsetX, y: 0, z: 0 })
          .gesture(
            // 绑定拖动手势
            PanGesture()
              .onActionStart((event: GestureEvent) => {
                console.info('Pan start');
              })// 当触发拖动手势时，根据回调函数修改组件的布局位置信息
              .onActionUpdate((event: GestureEvent) => {
                this.offsetX = this.positionX + event.offsetX;
                // this.offsetY = this.positionY + event.offsetY;
              })
              .onActionEnd(() => {

                recipeModel.addDetailedStep(this.nowId, 0, new DetailedStep(''))
                this.detailedSteps = recipeModel.getDetailedStepsById(this.nowId, 0) as DetailedStep[]
                this.positionX = this.offsetX;
                // this.positionY = this.offsetY;
                this.offsetX = 0
                this.positionX = 0
                // AppStorage.setOrCreate("steps", this.steps)
                // AppStorage.setOrCreate("detailedSteps", this.detailedSteps)

              })
          )

        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .shadow(ShadowStyle.OUTER_DEFAULT_SM)
        .borderRadius(30)
        .padding(13)

      }
      .width('100%')
      .padding({ right: 11, left: 11 })
      .alignItems(HorizontalAlign.Start)


      Row({ space: 10 }) {

        Button('返回')
          .backgroundColor('#FDD298')
          .width(80)
          .height(40)
          .type(ButtonType.Capsule)
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'FirstCreView')
          })
        Button('下一步')
          .type(ButtonType.Capsule)
          .width(80)
          .height(40)
          .backgroundColor('#3BFF00')
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'ThirdCreView')
          })

        Button('完成')
          .type(ButtonType.Capsule)
          .width(80)
          .height(40)
          .backgroundColor('#56F5DB')
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'BeginView')
            // AppStorage.setOrCreate("doneCount", this.doneCount++)
            AppStorage.setOrCreate("theRecipeDone", true)
          })
      }
      .margin({ top: 10, bottom: 10 })
      .layoutWeight(1)

    }
    .width('100%')
    .height('83%')

  }
}
