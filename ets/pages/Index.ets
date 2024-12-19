// import { UIView, LinearGradient, Rect, Color, Point, Column } from '@harmonyos/hyperspace';

import { WelcomePage } from './WelcomePage';
import { borderRadiuses } from '@ohos.arkui.node'
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { router } from '@kit.ArkUI';
import { CircleShape, EllipseShape, PathShape, RectShape } from "@ohos.arkui.shape";
import { UIContext } from '@ohos.arkui.UIContext';
import { LengthMetrics } from '@kit.ArkUI';
import { CustomTabBar } from '../components/CustomTabBar';
import { TabBarData, TabBarType, TabsInfo } from '../model/TabBarModel';
import { BeginView } from '../components/BeginView'
import { ContinueModel, log, RouterUtil } from '@common/utils';
import { MineView } from '../components/MineView';

import { SearchBar } from '../components/SearchBar';
import { FirstCreView } from '../components/FirstCreView';
import { SecondCreView } from '../components/SecondCreView';
import { ThirdCreView } from '../components/ThirdCreView';
import { ChooseRecipeView } from '../components/ChooseRecipeView';
import { CookingProcessView } from '../components/CookingProcessView';
import { MyIngredientsView } from '../components/MyIngredientsView';
import { MyAddIngredientsView } from '../components/MyAddIngredientsView';
import { HealthRecommendationView } from '../components/HealthRecommendationView';
import { MyRecipe } from '../components/MyRecipe';
import { detailedRecipe } from '../components/detailedRecipe';
import { HotRecipes } from '../components/HotRecipes';
import { MyConnectionView } from '../components/MyConnectionView';

let storage = LocalStorage.getShared();
const TAG = 'Index';

@Entry(storage)
@Component
struct Index {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 1;
  @State searchText: string = ''
  @State isFirst: boolean = true;
  @StorageProp('isChooseRecipeView') isChooseRecipeView: boolean = false
  @StorageProp('isCookingProcessView') isCookingProcessView: boolean = false
  @StorageProp('currentStep') currentStep: string = 'RecipeView';
  @StorageProp('MineCurrentStep') MineCurrentStep: string = 'MineView';
  @StorageProp('MineHaveSearchBar') MineHaveSearchBar: boolean = false;
  // @State @Watch('onSplashPageFinish') isSplashPage: boolean = true;
  @Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();
  @Provide('minePathStack') minePathStack: NavPathStack = new NavPathStack();
  @Provide('discoverPathStack') discoverPathStack: NavPathStack = new NavPathStack();
  @Provide('settingPathStack') settingPathStack: NavPathStack = new NavPathStack();
  uiContext: UIContext | undefined = undefined;
  pageStack: NavPathStack = new NavPathStack();
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  topRectHeight: string = AppStorage.get<number>('topRectHeight') + 'px';

  @Builder
  pageMap(name: string, param: object) {
    //页面
  }

  aboutToAppear() {

    if (this.isFirst) {
      this.currentIndex = 1
      this.isFirst = false
      // console.log('我就执行了一次' + this.currentIndex);
    }

    AppStorage.setOrCreate("PathStack", this.pageStack)
    AppStorage.setOrCreate("currentStep", 'BeginView')
    AppStorage.setOrCreate("currentIndex", this.currentIndex)
    AppStorage.setOrCreate("isChooseRecipeView", this.isChooseRecipeView)
    AppStorage.setOrCreate("MineCurrentStep", 'MineView')

    console.log('我为什么' + this.currentIndex);
    this.currentStep = AppStorage.get("currentStep") as string;

  }
  // onPageShow(): void {
  //
  //   AppStorage.setOrCreate("currentStep", 'BeginView')
  // }

  // private controller: TabsController = new TabsController()

  build() {
    Navigation(RouterUtil.navPathStack) {
      Stack() {
        Flex({
          direction: FlexDirection.Column
        }) {
          Tabs({ index: this.currentIndex }) {
            TabContent() {

              Column({ space: 15 }) {
                Column() {

                  SearchBar()

                  if (this.isChooseRecipeView) {

                    ChooseRecipeView()

                  } else if (this.isCookingProcessView) {

                    CookingProcessView()

                  }

                }
                .layoutWeight(1)

                if (this.isChooseRecipeView) {
                  Row({ space: 15 }) {
                    Image($r('app.media.ChooseRecipeCookStart'))
                      .width(160)
                      .height(80)
                      .objectFit(ImageFit.Auto)
                      .onClick(() => {

                        this.isCookingProcessView = true
                        AppStorage.setOrCreate("isChooseRecipeView", false)
                        AppStorage.setOrCreate("isCookingProcessView", true)
                        AppStorage.setOrCreate("currentIndex", 0)

                      })

                    Image($r('app.media.ChooseRecipeCookGiving'))
                      .width(160)
                      .height(80)
                      .objectFit(ImageFit.Auto)
                      .onClick(() => {

                        AppStorage.setOrCreate("currentIndex", 1)
                        AppStorage.setOrCreate("isChooseRecipeView", false)
                        AppStorage.setOrCreate("isCookingProcessView", false)
                      })

                  }
                  .width('100%')
                  .height(120)
                  .justifyContent(FlexAlign.Center)
                }

              }
              .width('100%')
              .height('100%')
              .backgroundColor('#FFFFFF')
            }

            TabContent() {
              Column({ space: 15 }) {
                SearchBar()
                if (this.currentStep === 'BeginView') {
                  BeginView()
                } else if (this.currentStep === 'FirstCreView') {
                  FirstCreView()
                } else if (this.currentStep === 'SecondCreView') {
                  SecondCreView()
                } else if (this.currentStep === 'ThirdCreView') {
                  ThirdCreView()
                }else if (this.currentStep === 'HealthRecommendationView') {
                  HealthRecommendationView()
                }else if (this.currentStep === 'HotRecipes') {
                  HotRecipes()
                }

              }
              .width('100%')
              .height('100%')
              .backgroundColor('#FFFFFF')

            }

            TabContent() {
              Column({ space: 15 }) {
                if (this.MineHaveSearchBar) {
                  SearchBar()
                }

                if (this.MineCurrentStep === 'MineView') {
                  MineView()
                } else if (this.MineCurrentStep === 'MyIngredientsView') {
                  MyIngredientsView()
                } else if (this.MineCurrentStep === 'MyAddIngredientsView') {
                  MyAddIngredientsView()
                } else if (this.MineCurrentStep === 'HealthRecommendationView') {
                  HealthRecommendationView()
                }else if (this.MineCurrentStep === 'MyRecipe') {
                  MyRecipe()
                }else if (this.MineCurrentStep === 'detailedRecipe') {
                  detailedRecipe()
                }else if (this.MineCurrentStep === 'MyConnectionView') {
                  MyConnectionView()
                }
              }
              .width('100%')
              .height('100%')
              .backgroundColor('#FFFFFF')

            }
          }
          .layoutWeight(1)
          .barHeight(0)
          .scrollable(false)
          .onChange((index) => {
            this.currentIndex = index;
          })

          if (this.isChooseRecipeView == false) {
            CustomTabBar({ currentIndex: $currentIndex })
          }

        }
      }

    }
    .navDestination(this.pageMap)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    // .margin({ top: this.topRectHeight, bottom: this.bottomRectHeight }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
  }
}

