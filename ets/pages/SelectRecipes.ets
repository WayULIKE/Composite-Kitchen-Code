import { router } from '@kit.ArkUI';
import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';

@Entry
@Component
struct SelectRecipes {


  build() {
    Column() {
      Text('SelectRecipes').offset({y:100})

    }

  }
}

// build() {
//   Column() {
//     Stack() {
//       Image($r('app.media.bkgnd'))
//         .width('100%')
//         .height('100%')
//       Column() {
//         Image($r('app.media.logo'))
//           .width(px2vp(327.71))
//           .height(px2vp(327.71))
//           .position({ x: 43.84, y: 224.2})
//         Image($r('app.media.word'))
//           .width(104)
//           .height(25)
//           .position({ x: 162, y:887  })
//       }
//     }
//     .width(428)
//     .height(926)
//   }
//
//
// }

// build() {
//   Column() {
//     Stack() {
//       Image($r('app.media.bkgnd'))
//         .width(px2vp(428))
//         .height(px2vp(926))
//       Column() {
//         Image($r('app.media.logo'))
//           .width(px2vp(327.71))
//           .height(px2vp(327.71))
//           .position({ x: px2vp(43.84), y: px2vp(224.2)})
//         Image($r('app.media.word'))
//           .width(px2vp(104))
//           .height(px2vp(25))
//           .position({ x: px2vp(162), y:px2vp(887 ) })
//       }
//     }
//     .width(px2vp(428))
//     .height(px2vp(926))
//   }
//
//
// }