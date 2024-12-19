import { router } from '@kit.ArkUI';
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';

@Entry
@Component
export  struct WelcomePage {
  aboutToAppear() {
    this.jumpToIndex()
    console.log("我是出现了+！！！")
  }

  jumpToIndex() {
    setTimeout(async () => {
      router.replaceUrl({
        url: 'pages/Index',
      })
    }, 1000)
  }

  build() {
    Column() {
      Stack() {
        Image($r("app.media.WelBackGround"))
          .width('100%')
          .height('100%')
        Column() {
          Image($r('app.media.logo'))
            .width(327.71 / PREVIEWER_V_ZOOM)
            .height(327.71 / PREVIEWER_H_ZOOM)
            .position({ x: 43.84 / PREVIEWER_V_ZOOM, y: 224.2 / PREVIEWER_H_ZOOM })
          Image($r('app.media.word'))
            .width(104 / PREVIEWER_V_ZOOM)
            .height(25 / PREVIEWER_H_ZOOM)
            .position({ x: 162 / PREVIEWER_V_ZOOM, y: 887 / PREVIEWER_H_ZOOM })
        }
      }

    }

  }
}

// @Entry
// @Component
// export struct WelcomePage {
//   @Link isSplashPage: boolean; //双向绑定
//   @State num: number = 1;
//   private timerId: number = 0;
//
//   aboutToAppear(): void {
//     this.timerId = setInterval(() => { //定时器
//       if (this.num === 4) {
//         clearInterval(this.timerId);
//         this.gotoHome();
//       }
//       this.num += 1;
//     }, 500)
//   }
//
//   build() {
//     Column() {
//       Stack() {
//         Image($r("app.media.WelBackGround"))
//           .width('100%')
//           .height('100%')
//         Column() {
//           Image($r('app.media.logo'))
//             .width(327.71 / PREVIEWER_V_ZOOM)
//             .height(327.71 / PREVIEWER_H_ZOOM)
//             .position({ x: 43.84 / PREVIEWER_V_ZOOM, y: 224.2 / PREVIEWER_H_ZOOM })
//           Image($r('app.media.word'))
//             .width(104 / PREVIEWER_V_ZOOM)
//             .height(25 / PREVIEWER_H_ZOOM)
//             .position({ x: 162 / PREVIEWER_V_ZOOM, y: 887 / PREVIEWER_H_ZOOM })
//         }
//       }
//
//     }
//   }
//
//   private gotoHome() {
//     this.isSplashPage = false
//     router.pushUrl({
//
//       url: 'pages/LoginPage' // 目标url
//     }, router.RouterMode.Standard, (err) => {
//       if (err) {
//         console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
//         return;
//       }
//       console.info('Invoke pushUrl succeeded.');
//     });
//
//   }
// }
