import { HotRecipe } from '../model/RecipeModel';
import { hotRecipeModel } from '../viewmodel/RecipeViewModel';

let recipeButtonNames: string[] =
  ['减脂轻食', '家常小炒', '自制小吃', '滋补汤类', '面点烘焙', '宝宝辅食', '异国料理'];

@Component
export struct HotRecipes {
  @State hotRecipes: HotRecipe[] = hotRecipeModel.list();

  build() {
    Scroll() {
      Column({space:8}) {
        // Iterate through each recipe category name
        ForEach(recipeButtonNames, (type: string) => {
          Column({space:6}) {
            Text(type)
              .fontSize(40)

            Scroll() {
              Row() {
                // Display recipes horizontally within each category
                ForEach(this.hotRecipes.filter(item => item.mainCategory === type), (item: HotRecipe) => {
                  Column({space:6}) {
                    Image(item.imageUrl)
                      .width(100)
                      .height(100)
                    Text(item.name)
                      .fontSize(16)
                      .maxLines(1)
                      .textAlign(TextAlign.Center)
                  }
                  .width(120)
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
          }
          .alignItems(HorizontalAlign.Start)
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('94%')
    .height('80%')
    .scrollable(ScrollDirection.Vertical)

  }
}
