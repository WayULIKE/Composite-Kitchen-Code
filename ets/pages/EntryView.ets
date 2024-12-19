import { WelcomePage } from './WelcomePage';
import { HomePage } from '../components/HomePage';
import { ToolPage } from './ToolPage';
import { MyPage } from './MyPage';
import { window } from '@kit.ArkUI';
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';

import { log, RouterUtil } from '@common/utils';

@Entry
@Component
struct EntryView {
  pageStack: NavPathStack = new NavPathStack();
  @State selectIndex: number = 0;
  @State @Watch('onSplashPageFinish') isSplashPage: boolean = true;
  @State selectedIndex: number = 2

  onSplashPageFinish() {
    //启动页结束后进行操作，如请求网络等
  }

  aboutToAppear(): void {
    AppStorage.setOrCreate("PathStack", this.pageStack)
  }

  @Builder
  pageMap(name: string, param: object) {
    //页面
  }

  build() {
    Navigation(RouterUtil.navPathStack) {
      if (this.isSplashPage) {
        WelcomePage({ isSplashPage: this.isSplashPage })

      } else {
        Stack() {
          if (this.selectIndex === 0) {
            HomePage()
          } else if (this.selectIndex === 1) {
            ToolPage()
          } else if (this.selectIndex === 2) {
            MyPage()
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(Color.Black)

        this.tabBuilder()
      }
    }
    .height('100%')
    .hideTitleBar(true)
    .navBarWidth('50%')
    .navDestination(this.pageMap)
    .mode(NavigationMode.Stack)
    .hideNavBar(false)

    // .toolbarConfiguration(this.isSplashPage ? undefined : this.tabBuilder)

    // .toolbarConfiguration(this.tabBuilder)

  }

  @Builder
  tabBuilder() {

    Row() {
      ForEach(['首页', '工具', '我的'], (item: string, index) => {
        Column() { //这里可以自己封装图标等
          Text(item)
            .fontColor(this.selectIndex === index ? Color.Red : Color.Black)
            .fontSize(this.selectIndex === index ? 25 : 18)
        }
        .height("100%")
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)
        .padding({ top: 5, bottom: 5 })
        .onClick(() => {
          this.selectIndex = index;
        })
      })
    }
    .height(50)
    .width('100%')

    // .backgroundColor(Color.Black)

  }
}



