import { Recipe } from '../model/RecipeModel'
import recipeModel from '../viewmodel/RecipeViewModel'

@Preview
@Component
export struct MyRecipe {
  @State myRecipes: Recipe[] = recipeModel.list()
aboutToAppear(): void {
  console.log(recipeModel.list()+'???我被打印了？'); // 输出食谱列表，检查是否成功添加
  }
  build() {


    Column({ space: 6 }) {
      Text('我的食谱')
        .fontSize(32)
        .fontColor('#105805')
        .fontWeight(FontWeight.Regular)

      List({ space: 6 }) {
        ForEach(this.myRecipes, (item: Recipe, index: number) => {
          ListItem() {

            Row() {
              Text(item.name)
                .fontColor('#2F622C') //
            }
            .width('95%')
            .margin({ left: 11, right: 11 })
            .padding({ left: 11, right: 11 })
            .height(40)
            .backgroundImage($r('app.media.ChooseRecipeListBackground'))
            .backgroundImageSize({ width: '100%', height: '100%' })
            .onClick(()=>{

              AppStorage.setOrCreate('detailedIndex', index)
              AppStorage.setOrCreate('MineCurrentStep', 'detailedRecipe')
              AppStorage.setOrCreate('MineHaveSearchBar', false)

            })

          }

        })
      }
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .edgeEffect(EdgeEffect.None)
      .height('55%')
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
    .width('90%')
    .height('90%')
    .backgroundImage($r('app.media.ChooseRecipeBackground'))
    .backgroundImageSize({ width: '100%', height: '100%' })

    .padding({ top: 11 })
  }
}