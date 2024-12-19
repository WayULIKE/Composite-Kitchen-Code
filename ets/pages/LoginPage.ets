import { router } from '@kit.ArkUI';
import { PREVIEWER_V_ZOOM,PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';



@Entry
@Component
struct LoginPage {

  @State rotateAngle: number = 10
  build() {
    Column() {
      Image($r('app.media.logo'))
        .width(327.71 / PREVIEWER_V_ZOOM)
        .height(327.71 / PREVIEWER_H_ZOOM)
        .position({ x: 43.84 / PREVIEWER_V_ZOOM, y: 108.2 / PREVIEWER_H_ZOOM })
        .rotate({ angle: this.rotateAngle })
      Image($r('app.media.Account'))
        .width(80/ PREVIEWER_V_ZOOM)
        .height(20 / PREVIEWER_H_ZOOM)
        .position({ x: 70 / PREVIEWER_V_ZOOM, y: 504 / PREVIEWER_H_ZOOM })

      Image($r('app.media.rect170'))
        .width(322 / PREVIEWER_V_ZOOM)
        .height(54 / PREVIEWER_H_ZOOM)
        .position({ x: 53 / PREVIEWER_V_ZOOM, y: 529 / PREVIEWER_H_ZOOM })


      Image($r('app.media.PassWord'))
        .width(80/ PREVIEWER_V_ZOOM)
        .height(20 / PREVIEWER_H_ZOOM)
        .position({ x: 70 / PREVIEWER_V_ZOOM, y: 598 / PREVIEWER_H_ZOOM })

      Image($r('app.media.rect171'))
        .width(322 / PREVIEWER_V_ZOOM)
        .height(54 / PREVIEWER_H_ZOOM)
        .position({ x: 53 / PREVIEWER_V_ZOOM, y: 623 / PREVIEWER_H_ZOOM })

      Image($r('app.media.word'))
        .width(104 / PREVIEWER_V_ZOOM)
        .height(25 / PREVIEWER_H_ZOOM)
        .position({ x: 162 / PREVIEWER_V_ZOOM, y: 887 / PREVIEWER_H_ZOOM })


    }
    .width(428 / PREVIEWER_V_ZOOM)
    .height(926 / PREVIEWER_H_ZOOM)

  }
}