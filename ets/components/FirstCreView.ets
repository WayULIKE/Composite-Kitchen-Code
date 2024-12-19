import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { LengthMetrics } from '@kit.ArkUI';
import { global, log, RouterUtil } from '@common/utils';
import { SearchBar } from './SearchBar';
import { util } from '@kit.ArkTS';
import { DetailedStep, Flavor, Food, Recipe, Seasoning, Step } from '../model/RecipeModel';
import recipeModel from '../viewmodel/RecipeViewModel';

const TAG = 'FirstCreView';

@Component
export struct FirstCreView {
  @State searchText: string = ''
  @State availableFlavor: string = ''
  @State flavorLevel: number = 0
  @StorageProp('nowId') nowId: string = '';
  @State text: string = recipeModel.getRecipeNameById(this.nowId)
  @State foods: Food[] = recipeModel.getFoodsByRecipeId(this.nowId) as Food[]
  @State seasonings: Seasoning[] = recipeModel.getSeasoningsByRecipeId(this.nowId) as Seasoning[]
  @State flavorsData: Flavor[] = recipeModel.getFlavorByRecipeId(this.nowId) as Flavor[]
  @State yOffset: number = 0;
  // @StorageProp('foods') foods: Food[] = [];
  // @StorageProp('seasonings') seasonings: Seasoning[] = [];
  // @StorageProp('flavorsData') flavorsData: Flavor[] = [];
  // @StorageProp('recipes') recipes: Recipe[] = [];
  // @StorageProp('doneCount') doneCount: number = 0;
  private availableFlavors: string[] = ['酸', '甜', '苦', '辣', '咸'];
  private flavorLevels: string[] =
    ['吃不出来', '隐约可尝', '恰到好处', '略显突出', '强烈冲击'];
  TextInputController: TextInputController = new TextInputController()
  scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    // this.foods = AppStorage.get("foods") as Food[];
    // this.foods = AppStorage.get("foods") as Food[];
    // this.seasonings = AppStorage.get("seasonings") as Seasoning[];
    // this.flavorsData = AppStorage.get("flavorsData") as Flavor[];

    // this.recipes = AppStorage.get("recipes") as Recipe[];
    // this.foods = this.recipes[this.doneCount].foods
    // this.seasonings = this.recipes[this.doneCount].seasonings
    // this.flavorsData = this.recipes[this.doneCount].flavor
    // this.doneCount = AppStorage.get("doneCount") as number;

  }

  aboutToDisappear() {
    // AppStorage.setOrCreate("foods", this.foods)
    // AppStorage.setOrCreate("seasonings", this.seasonings)
    // AppStorage.setOrCreate("recipes", this.recipes)
  }

  // storeRecipeData(){
  //   AppStorage.setOrCreate("foods", this.foods)
  //   AppStorage.setOrCreate("seasonings", this.seasonings)
  //   AppStorage.setOrCreate("availableFlavors", this.availableFlavors)
  // }


  build() {

    Column({ space: 15 }) {
      Scroll(this.scroller) {
        Column({ space: 11 }) {
          Text('给你的菜起一个名字吧!')
            .fontSize(15)
          TextInput({ text: this.text, placeholder: '例：爆炒双脆', controller: this.TextInputController })
            .placeholderColor(Color.Black)
            .placeholderFont({ size: 22, weight: 400 })
            .caretColor(Color.Blue)
            .width('93%')
            .height(60)
            .fontSize(22)
            .fontColor(Color.Black)
            .onChange((value: string) => {

              recipeModel.updateRecipeName(this.nowId, value)
            })
            .backgroundColor('#ECF4E5')
            .shadow(ShadowStyle.OUTER_FLOATING_SM)
            .borderRadius(12)
          Text('你的菜里有什么？')
            .fontSize(15)
            .fontColor(Color.Gray)
          Text('食材')
            .fontSize(18)
            .fontColor(Color.Black)
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM), cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM) }
          }) {
            ForEach(this.foods, (item: Food) => {

              Row({ space: 6 }) {
                TextInput({ placeholder: '名称', text: item.name })
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .onChange((value) => {
                    item.name = value;
                  })
                  .fontSize(15)
                  .width('auto')
                  .backgroundColor(Color.White)

                TextInput({ placeholder: '数量', text: item.quantity + '' })
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .onChange((value) => {
                    item.quantity = value;
                  })
                  .fontSize(15)
                  .width('auto')
                  .backgroundColor(Color.White)
                Text('个')
                  .fontSize(15)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .borderRadius(10)
                Text('\t')

              }

            })
            Button('+')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Regular)
              .backgroundColor(Color.White)
              .onClick(() => {
                recipeModel.addFood(this.nowId, new Food('', ''))
                this.foods = recipeModel.getFoodsByRecipeId(this.nowId) as Food[]
              })
              .shadow(ShadowStyle.OUTER_DEFAULT_SM)
              .width(50)

          }

          Text('调料')
            .fontSize(18)
            .fontColor(Color.Black)
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM), cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM) }
          }) {
            ForEach(this.seasonings, (item: Seasoning) => {

              Row({ space: 6 }) {
                TextInput({ placeholder: '名称', text: item.name })
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .onChange((value) => {
                    item.name = value;
                  })
                  .fontSize(15)
                  .width('auto')
                  .backgroundColor(Color.White)

                TextInput({ placeholder: '数量', text: item.quantity + '' })
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .onChange((value) => {
                    item.quantity = value;
                  })
                  .fontSize(15)
                  .width('auto')
                  .backgroundColor(Color.White)
                Text('g')
                  .fontSize(15)
                  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                  .borderRadius(10)
                Text('\t')

              }

            })
            Button('+')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Regular)
              .backgroundColor(Color.White)
              .onClick(() => {
                // this.seasonings.push(new Seasoning('', ''));
                // this.recipes[0].seasonings = this.seasonings
                recipeModel.addSeasoning(this.nowId, new Seasoning('', ''))
                this.seasonings = recipeModel.getSeasoningsByRecipeId(this.nowId) as Seasoning[]
              })
              .shadow(ShadowStyle.OUTER_DEFAULT_SM)
              .width(50)

          }

          Row() {
            Text('你的菜是什么口味？')
              .fontSize(15)
              .fontColor(Color.Gray)
            Image($r('app.media.SeasoningImage'))
              .width(30)
          }

          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM), cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM) }
          }) {
            ForEach(this.flavorsData, (item: Flavor) => {
              Column({ space: 6 }) {
                Row({ space: 6 }) {
                  Text(item.name)
                    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
                    .fontSize(15)
                    .width(40)
                    .height(40)
                    .backgroundColor(Color.White)
                    .borderRadius(10)
                    .textAlign(TextAlign.Center)
                    .padding({ left: 10, right: 10 })
                }

                Row({ space: 6 }) {


                  Text(this.flavorLevels[item.level-1])
                    .fontSize(10)
                    .width(50)
                    .height(30)
                    .backgroundColor('#F2D6D6')
                    .borderRadius(20)
                    .align(Alignment.Center)
                    .padding({ left: 5, right: 5 })
                }
              }

            })
            Button('+')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Regular)
              .backgroundColor(Color.White)
              .onClick(() => {
                TextPickerDialog.show({
                  range: this.flavorLevels,
                  onAccept: (value: TextPickerResult) => {
                    this.flavorLevel = value.index as number
                  },


                })
                TextPickerDialog.show({
                  range: this.availableFlavors,
                  onAccept: (value: TextPickerResult) => {
                    // let arr = Array.isArray(value.index) ? value.index : [value.index];
                    // for (let i = 0; i < arr.length; i++) {
                    //   this.flavorsData.push(new Flavor(this.availableFlavors[arr[i]])); // 新增列表项数据toDoData(可选事项)
                    // }
                    this.availableFlavor = this.availableFlavors[Number(value.index)]
                    console.log(this.availableFlavor + 'acscas')
                  },
                  onDidDisappear: () => {
                    // this.flavorsData.push(new Flavor(this.availableFlavor, this.flavorLevel)); // 新增列表项数据toDoData(可选事项)
                    recipeModel.addFlavor(this.nowId, new Flavor(this.availableFlavor, this.flavorLevel + 1))
                    this.flavorsData = recipeModel.getFlavorByRecipeId(this.nowId) as Flavor[]
                  }

                })

                // this.recipes[0].flavor = this.flavorsData
              })
              .shadow(ShadowStyle.OUTER_DEFAULT_SM)
              .width(50)

          }

        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 13, right: 13 })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .edgeEffect(this.yOffset <= 0 ? EdgeEffect.Spring : EdgeEffect.None) // 滚动到边沿后回弹
      .onDidScroll(() => {
        this.yOffset = this.scroller.currentOffset().yOffset;
      })


      Row({ space: 10 }) {

        Button('返回')
          .backgroundColor('#FDD298')
          .width(80)
          .height(40)
          .type(ButtonType.Capsule)
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'BeginView')
          })
        Button('下一步')
          .type(ButtonType.Capsule)
          .width(80)
          .height(40)
          .backgroundColor('#79F555')
          .fontColor(Color.Black)
          .onClick(() => {
            AppStorage.setOrCreate("currentStep", 'SecondCreView')


          })
      }
      .margin({ top: 10, bottom: 10 })
    }
    .width('100%')
    .height('83%')

  }
}


