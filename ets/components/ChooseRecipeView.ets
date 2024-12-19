import { RecipeSelection } from '../model/RecipeModel';
import { recipeSelectionModel } from '../viewmodel/RecipeViewModel';

@Preview
@Component
export struct ChooseRecipeView {
  private selectedRecipes: RecipeSelection[] = recipeSelectionModel.list();
  @State clickedIndex: number = -1; // 追踪点击项的索引

  build() {
    Column() {
      Scroll() {
        Column({ space: 6 }) {
          Text('选择食谱')
            .fontSize(32)
            .fontColor('#105805')
            .fontWeight(FontWeight.Regular)

          List({ space: 6 }) {
            ForEach(this.selectedRecipes, (item: RecipeSelection, index: number) => {
              ListItem() {
                if (this.clickedIndex === index) {
                  Row() {
                    Row({ space: 6 }) {
                      Column() {
                        Text(item.name)
                          .fontColor('#2F622C')
                        Row({ space: 6 }) {
                          if (item.isMine) {
                            Image($r('app.media.ChooseRecipeMine'))
                              .width(40)
                              .height(20)
                          }
                          if (item.isFrequent) {
                            Image($r("app.media.ChooseRecipeCommonUse"))
                              .width(40)
                              .height(20)
                          }
                        }

                      }
                      .alignItems(HorizontalAlign.Start)
                      .width('40%')

                      Column() {
                        if (item.isFavorite) {
                          Image($r('app.media.ChooseRecipeStar'))
                            .width(15)
                            .height(15)
                        }
                        if (item.isMine) {
                          Text(item.successRate + '%成功率')
                            .fontSize(6)
                            .fontColor('#2F622C')
                          Progress({ value: item.successRate, total: 100, type: ProgressType.Linear })
                            .color('#ff58d450')

                        }
                        Text(item.viewsCount + '人看过')
                          .fontSize(6)
                          .fontColor(Color.Gray)
                      }
                      .alignItems(HorizontalAlign.End)
                      .width('60%')
                    }

                  }
                  .width('95%')
                  .margin({ left: 11, right: 11 })
                  .padding({ left: 11, right: 11 })
                  .height(60)
                  .backgroundImage($r('app.media.ChooseRecipeListBackground'))
                  .backgroundImageSize({ width: '100%', height: '100%' })
                  .onClick(() => {
                    this.clickedIndex = index; // 设置点击的索引
                    console.log("点击了第 " + index + " 行");
                    console.log("点击了第 " + this.clickedIndex + " 行？");
                  })
                } else {
                  Row() {
                    Text(item.name)
                      .fontColor('#2F622C') // 点击后改变颜色
                    Blank()
                    if (item.isMine) {
                      Image($r('app.media.ChooseRecipeMine'))
                        .width(40)
                        .height(20)
                    }
                    if (item.isFrequent) {
                      Image($r("app.media.ChooseRecipeCommonUse"))
                        .width(40)
                        .height(20)
                    }
                    if (item.isFavorite) {
                      Image($r('app.media.ChooseRecipeStar'))
                        .width(15)
                        .height(15)
                    } else {
                      Blank()
                        .width(15)
                    }
                  }
                  .width('95%')
                  .margin({ left: 11, right: 11 })
                  .padding({ left: 11, right: 11 })
                  .height(40)
                  .backgroundImage($r('app.media.ChooseRecipeListBackground'))
                  .backgroundImageSize({ width: '100%', height: '100%' })
                  .onClick(() => {
                    this.clickedIndex = index; // 设置点击的索引
                    console.log("点击了第 " + index + " 行");
                    console.log("点击了第 " + this.clickedIndex + " 行？");
                  })

                }

              }
            })
          }
          .nestedScroll({
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
          .edgeEffect(EdgeEffect.None)
          .height('65%')
          .width('100%')

          Column({ space: 6 }) {
            Image($r('app.media.ChooseRecipeRecommendedText'))
              .width(200)
              .height(30)
              .margin({ left: 11 })
            Image($r('app.media.ChooseRecipeRecommendedImage'))
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .height('25%')
        }
      }
      .backgroundImage($r('app.media.ChooseRecipeBackground'))
      .backgroundImageSize({ width: '100%', height: '100%' })
      .width('90%')
      .height('90%')
      .align(Alignment.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 11 })
  }
}