import { DetailedStep, Flavor, Food, Recipe, Seasoning, Step } from '../model/RecipeModel'
import recipeModel from '../viewmodel/RecipeViewModel'

@Preview
@Component
export struct detailedRecipe {
  @State myRecipes: Recipe[] = recipeModel.list()
  @StorageProp('detailedIndex') detailedIndex: number = 0
  @State recipe: Recipe = this.myRecipes[this.detailedIndex]; // 假设选择第一个食谱，或者根据需求进行动态分配
  scroller: Scroller = new Scroller()
  build() {

    Column({ space: 40 }) {
      Row() {
        Image($r('app.media.backButton'))
          .width(30)
          .height(30)
          .onClick(() => {
            AppStorage.setOrCreate('MineCurrentStep', 'MyRecipe')
            AppStorage.setOrCreate('MineHaveSearchBar', true)
          })
        Blank()

        Text(this.recipe.name)
          .fontSize(20)
        Blank()
        Blank()
          .width(30)
          .height(30)

      }
      .width('100%')
      .height('14%')
      .padding({ top: 24, left: 16 })
      .backgroundImage($r('app.media.SearchBarBackground'))
      .backgroundImageSize({ width: '100%', height: '500%' })
      .backgroundImagePosition({ x: 0, y: -400 })
      .justifyContent(FlexAlign.Start)

      Scroll(this.scroller) {
        Column({ space: 6 }) {

          // 食材部分
          Text('食材')
            .fontSize(20)
            .margin({ bottom: 8 });
          Column({ space: 4 }) {
            ForEach(this.recipe.foods, (food: Food) => {
              Row() {
                Text(food.name).fontSize(16);
                Text(food.quantity).fontSize(16).margin({ left: 10 });
              }
            });
          }

          // 调料部分
          Text('调料')
            .fontSize(20)
            .margin({ top: 16, bottom: 8 });
          Column({ space: 4 }) {
            ForEach(this.recipe.seasonings, (seasoning: Seasoning) => {
              Row() {
                Text(seasoning.name).fontSize(16);
                Text(seasoning.quantity).fontSize(16).margin({ left: 10 });
              }
            });
          }

          // 口味部分
          Text('口味')
            .fontSize(20)
            .margin({ top: 16, bottom: 8 });
          Column({ space: 4 }) {
            ForEach(this.recipe.flavor, (flavor: Flavor) => {
              Row() {
                Text(flavor.name).fontSize(16);
                Text('强度: ' + flavor.level).fontSize(16).margin({ left: 10 });
              }
            });
          }

          // 步骤部分
          Text('步骤')
            .fontSize(20)
            .margin({ top: 16, bottom: 8 });
          Column({ space: 12 }) {
            ForEach(this.recipe.steps, (step: Step, index) => {
              Column() {
                Text('步骤 ' + (index + 1) + ': ' + step.name).fontSize(18).fontWeight(FontWeight.Bold);
                ForEach(step.detailedSteps, (detailStep: DetailedStep) => {
                  Row() {
                    Text('- ' + detailStep.content).fontSize(16).margin({ left: 20 });
                  }
                });
              }
            });
          }.alignItems(HorizontalAlign.Center)

        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(12)

      }
      .shadow(ShadowStyle.OUTER_DEFAULT_SM)
      .width('80%')
      .height('60%')
      .borderRadius(30)
      .scrollable(ScrollDirection.Vertical)


    }

  }
}



