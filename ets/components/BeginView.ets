import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { LengthMetrics, router } from '@kit.ArkUI';
import { DetailedStep, Recipe, Step } from '../model/RecipeModel';
import { util } from '@kit.ArkTS';
import {recipeModel} from '../viewmodel/RecipeViewModel';

let recipeButtonNames: string[] =
  ['减脂轻食', '家常小炒', '自制小吃', '滋补汤类', '面点烘焙', '宝宝辅食', '异国料理', '查看更多'];
const TAG = 'BeginView';

@Component
export struct BeginView {
  // @StorageProp('recipes') recipes: Recipe[] = [];
  @State value: string = '';
  @StorageProp('theRecipeDone') theRecipeDone: boolean = true;
  @StorageProp('nowId') nowId: string = '';

  aboutToAppear(): void {
    // AppStorage.setOrCreate("theRecipeDone", true)
  }

  aboutToDisappear(): void {
    // AppStorage.setOrCreate("recipes", this.recipes)
  }

  build() {

    Column() {

      Column({ space: 11 }) {

        Column({ space: 14 }) {
          Text('欢迎回来，我爱吃饭！')
            .margin({ top: 11 })// .position({ x: 31 / PREVIEWER_V_ZOOM, y: 149 / PREVIEWER_H_ZOOM })
            .fontSize(18)
          Text('热门食谱')// .position({ x: 31 / PREVIEWER_V_ZOOM, y: 193 / PREVIEWER_H_ZOOM })
            .fontSize(32)
            .fontWeight(FontWeight.Bold)

        }
        .alignItems(HorizontalAlign.Start)
        .width('87%')

        Flex({
          wrap: FlexWrap.Wrap,
          space: { main: LengthMetrics.vp(6 / PREVIEWER_H_ZOOM), cross: LengthMetrics.vp(13 / PREVIEWER_H_ZOOM) }
        }) { // 子组件多行布局
          ForEach(recipeButtonNames, (item: string) => {
            Button(item)
              .fontSize(13 / PREVIEWER_H_ZOOM)
              .width(88 / PREVIEWER_H_ZOOM)
              .height(30 / PREVIEWER_V_ZOOM)
              .shadow({
                radius: 20,
                color: '#ffd4d4d4',
                offsetX: 0,
                offsetY: 0
              })
              .backgroundColor(Color.White)
              .fontColor(Color.Black)
              .type(ButtonType.Normal)
              .borderRadius(6)
              .onClick(() => {
                AppStorage.setOrCreate('currentStep' ,'HotRecipes')
              })
          })

        }
        .width('90%')
        // .position({ x: 31 / PREVIEWER_V_ZOOM, y: 242 / PREVIEWER_H_ZOOM })
        .margin({ top: 8 })

        Column() {
          Text('每日推荐')// .position({ x: 31 / PREVIEWER_V_ZOOM, y: 346 / PREVIEWER_H_ZOOM })
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)
        .width('87%')

        Image($r('app.media.IndexComList'))// Rect()
          .width(423 / PREVIEWER_V_ZOOM)
          .height(130 / PREVIEWER_H_ZOOM)
        // .position({ x: 5 / PREVIEWER_V_ZOOM, y: 405 / PREVIEWER_H_ZOOM })


        Row() {
          Column() {
            Stack() {

              Image($r('app.media.IndexShoppingList'))
                .width(180 / PREVIEWER_V_ZOOM)
                .height(250 / PREVIEWER_H_ZOOM)
                .borderRadius(20)
              Column({ space: 11 }) {
                Text('购物清单')// .position({ x: 16 / PREVIEWER_V_ZOOM, y: 19 / PREVIEWER_H_ZOOM })
                  .fontSize(32)
                  .fontColor('#0D943F')
                  .fontWeight(FontWeight.Normal)

                Text('海蜇皮 250g')// .position({ x: 19 / PREVIEWER_V_ZOOM, y: 65 / PREVIEWER_H_ZOOM })
                  .fontSize(19)
                  .fontColor('#9FA899')
                  .fontWeight(FontWeight.Normal)
                  .backgroundColor('#F1FFE8')
                  .width(131 / PREVIEWER_V_ZOOM)
                  .height(41 / PREVIEWER_H_ZOOM)
                  .textAlign(TextAlign.Start)
                  .padding(6)
                  .borderRadius(21)
                  .shadow(ShadowStyle.OUTER_DEFAULT_SM)
                Text('猪腰    500g')// .position({ x: 19 / PREVIEWER_V_ZOOM, y: 116 / PREVIEWER_H_ZOOM })
                  .fontSize(19)
                  .fontColor('#9FA899')
                  .fontWeight(FontWeight.Normal)
                  .backgroundColor('#F1FFE8')
                  .width(131 / PREVIEWER_V_ZOOM)
                  .height(41 / PREVIEWER_H_ZOOM)
                  .textAlign(TextAlign.Start)
                  .padding(6)
                  .borderRadius(21)
                  .shadow(ShadowStyle.OUTER_DEFAULT_SM)
                Text('洋葱      1头')// .position({ x: 19 / PREVIEWER_V_ZOOM, y: 167 / PREVIEWER_H_ZOOM })
                  .fontSize(19)
                  .fontColor('#9FA899')
                  .fontWeight(FontWeight.Normal)
                  .backgroundColor('#F1FFE8')
                  .width(131 / PREVIEWER_V_ZOOM)
                  .height(41 / PREVIEWER_H_ZOOM)
                  .textAlign(TextAlign.Start)
                  .padding(6)
                  .borderRadius(21)
                  .shadow(ShadowStyle.OUTER_DEFAULT_SM)
              }

            }
          }
          // .position({ x: 32 / PREVIEWER_V_ZOOM, y: 560 / PREVIEWER_H_ZOOM })
          // .width(172 / PREVIEWER_V_ZOOM)
          // .height(227 / PREVIEWER_H_ZOOM)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 20, right: 11 })

          Column({ space: 11 }) {
            Image($r('app.media.IndexButton0'))// .position({ x: 221 / PREVIEWER_V_ZOOM, y: 560 / PREVIEWER_H_ZOOM })
              .width(180 / PREVIEWER_V_ZOOM)
              .height(67 / PREVIEWER_H_ZOOM)
              .onClick(() => {
                AppStorage.setOrCreate("currentStep", 'FirstCreView')
                if (this.theRecipeDone) {
                  this.nowId = util.generateRandomUUID(true)
                  AppStorage.setOrCreate('nowId', this.nowId)
                  recipeModel.addRecipe(new Recipe(this.nowId, '', [], [], [], []))
                  recipeModel.addStep(this.nowId, new Step('', [new DetailedStep('')]))
                }
                AppStorage.setOrCreate("theRecipeDone", false)
              })


            Image($r('app.media.IndexButton1'))// .position({ x: 221 / PREVIEWER_V_ZOOM, y: 638 / PREVIEWER_H_ZOOM })
              .width(180 / PREVIEWER_V_ZOOM)
              .height(67 / PREVIEWER_H_ZOOM)
              .onClick(() => {
                AppStorage.setOrCreate('currentStep' ,'HotRecipes')
              })
            Image($r('app.media.IndexButton2'))// .position({ x: 221 / PREVIEWER_V_ZOOM, y: 710 / PREVIEWER_H_ZOOM })
              .width(180 / PREVIEWER_V_ZOOM)
              .height(67 / PREVIEWER_H_ZOOM)
              .onClick(() => {
                AppStorage.setOrCreate('currentStep' ,'HealthRecommendationView')
              })

          }
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .justifyContent(FlexAlign.Start)
        .height('100%')
      }
      .width('97%')
      .height('100%')

    }
    .width('100%')
    .height('100%')

  }
}
