import { DetailedStep, Flavor, Food, Recipe, Seasoning, Step } from '../model/RecipeModel';
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { LengthMetrics } from '@kit.ArkUI';
import { text } from '@kit.ArkGraphics2D';
import recipeModel from '../viewmodel/RecipeViewModel';
import { common } from '@kit.AbilityKit';
import { CameraUtil } from '../common/utils/CameraUtil';

@Component
export struct ThirdCreView {
  // @StorageProp('steps') steps: Step[] = [];
  // @StorageProp('detailedSteps') detailedSteps: DetailedStep[] = [];
  @State offsetX: number[] = [0];
  @State positionX: number[] = [0];
  // @StorageProp('doneCount') doneCount: number = 0;
  // @StorageProp('recipes') recipes: Recipe[] = [];
  scroller: Scroller = new Scroller()
  private swiperController: SwiperController = new SwiperController()
  @StorageProp('nowId') nowId: string = '';
  @State steps: Step[] = recipeModel.getStepsByRecipeId(this.nowId)

  aboutToAppear(): void {
    // this.steps = AppStorage.get("steps") as Step[];
    // this.detailedSteps = AppStorage.get("detailedSteps") as DetailedStep[];
    // this.doneCount = AppStorage.get("doneCount") as number;
    // this.recipes = AppStorage.get("recipes") as Recipe[];
  }

  aboutToDisappear() {
    // AppStorage.setOrCreate("steps", this.steps)
    // AppStorage.setOrCreate("detailedSteps", this.detailedSteps)


  }

  build() {

    Column({ space: 13 }) {


      Scroll() {
        Column({ space: 6 }) {
          Text('详细步骤')
            .fontSize(32)

          List({ space: 8 }) {
            ForEach(this.steps, (BigItem: Step, BigIndex: number) => {
              ListItem() {
                Column({ space: 8 }) {
                  Column({ space: 11 }) {
                    Text('输入步骤名称')
                      .fontSize(14)
                      .fontColor(Color.Black)
                      .width('auto')

                    TextInput({ placeholder: '例:处理食材', text: BigItem.name })
                      .placeholderColor(Color.Black)
                      .backgroundColor('#FCEBE4')
                      .onChange((value) => {
                        BigItem.name = value
                      })
                    Row({ space: 11 }) {
                      Text('输入详细内容')
                        .fontSize(12)
                        .fontColor(Color.Black)
                    }


                    Row() {
                      // if (this.haveMore) {
                      Swiper(this.swiperController) {
                        ForEach(this.steps[BigIndex].detailedSteps, (SmallItem: DetailedStep, SmallIndex: number) => {
                          Column() {
                            /*
                             * todo:
                             * 1.DetailedStep ID 2的UI没更新
                             * 2.每一次的Step的 DetailedStep ID没有刷新
                             *
                             * */
                            TextInput({
                              placeholder: '在这里输入详细的步骤',
                              text: SmallItem.content
                            })
                              .height('auto')
                              .fontSize(14)
                              .align(Alignment.TopStart)
                              .backgroundColor('#F6FFEE')
                              .onChange((value) => {
                                // this.steps[BigIndex].detailedSteps[SmallIndex].detailedStepContent = value;
                                SmallItem.content = value;
                              })
                            Row() {
                              if (SmallItem.recipeImages) {
                                ForEach(SmallItem.recipeImages, (item: ResourceStr) => {
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
                                  SmallItem.recipeImages?.push(photoUri)
                                  this.steps = recipeModel.getStepsByRecipeId(this.nowId)
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
                      .index(1)
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


                      // } else {


                      // }

                    }
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .borderRadius(30)
                    .translate({ x: this.offsetX[BigIndex], y: 0, z: 0 })
                    .gesture(
                      // 绑定拖动手势
                      PanGesture()
                        .onActionStart((event: GestureEvent) => {
                          console.info('Pan start');
                        })// 当触发拖动手势时，根据回调函数修改组件的布局位置信息
                        .onActionUpdate((event: GestureEvent) => {
                          this.offsetX[BigIndex] = this.positionX[BigIndex] + event.offsetX;
                          // this.offsetY = this.positionY + event.offsetY;
                        })
                        .onActionEnd(() => {
                          recipeModel.addDetailedStep(this.nowId, BigIndex, new DetailedStep(''))
                          this.steps = recipeModel.getStepsByRecipeId(this.nowId)
                          this.positionX[BigIndex] = this.offsetX[BigIndex];
                          // this.positionY = this.offsetY;
                          this.offsetX[BigIndex] = 0
                          this.positionX[BigIndex] = 0
                          // AppStorage.setOrCreate("steps", this.steps)

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

              }
            }, (item: string) => item)
          }
          .nestedScroll({
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
          .edgeEffect(EdgeEffect.None)
          .height('80%')
          .width('100%')
        }
      }


      Row({ space: 10 }) {

        Button('返回')
          .backgroundColor('#FDD298')
          .width(80)
          .height(40)
          .type(ButtonType.Capsule)
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'SecondCreView')
          })
        Button('下一步')
          .type(ButtonType.Capsule)
          .width(80)
          .height(40)
          .backgroundColor('#3BFF00')
          .fontColor(Color.Black)
          .onClick(() => {
            // this.steps.push(new Step('', this.detailedSteps))
            recipeModel.addStep(this.nowId, new Step('', [new DetailedStep('')]))
            this.steps = recipeModel.getStepsByRecipeId(this.nowId)
            this.offsetX.push(0)
            this.positionX.push(0)
          })

        Button('完成')
          .type(ButtonType.Capsule)
          .width(80)
          .height(40)
          .backgroundColor('#56F5DB')
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'BeginView')
            AppStorage.setOrCreate("theRecipeDone", true)
            // AppStorage.setOrCreate("doneCount", this.doneCount++)
            // this.recipes[0].steps = this.steps
            printRecipe(recipeModel.getById(this.nowId))
          })
      }
      .margin({ top: 10, bottom: 10 })
      .layoutWeight(1)

    }
    .width('100%')
    .height('83%')

  }
}


function printRecipe(recipe: Recipe): void {
  console.log(`Recipe ID: ${recipe.id}`);
  console.log(`Name: ${recipe.name}`);

  // 打印食物
  console.log("Foods:");
  recipe.foods.forEach((food: Food) => {
    console.log(`  Name: ${food.name}, Quantity: ${food.quantity}`);
  });

  // 打印调料
  console.log("Seasonings:");
  recipe.seasonings.forEach((seasoning: Seasoning) => {
    console.log(`  - Seasoning ID: ${seasoning}, Name: ${seasoning.name}, Quantity: ${seasoning.quantity}`);
  });

  // 打印口味
  console.log("Flavors:");
  recipe.flavor.forEach((flavor: Flavor) => {
    console.log(`  - Flavor: ${flavor.name}, Level: ${flavor.level}`);
  });

  // 打印步骤及详细步骤
  console.log("Steps:");
  recipe.steps.forEach((step: Step) => {
    console.log(`  - Step ID: ${step.id}, Name: ${step.name}`);
    console.log("    Detailed Steps:");
    step.detailedSteps.forEach((detailedStep: DetailedStep) => {
      console.log(`      - DetailedStep ID: ${detailedStep.id}, Content: ${detailedStep.content}`);
      if (detailedStep.recipeImages && detailedStep.recipeImages.length > 0) {
        console.log(`        Recipe Images: ${detailedStep.recipeImages.join(", ")}`);
      }
    });
  });
}