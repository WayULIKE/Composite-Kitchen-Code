import Constants from '../common/constants/CommonConstants'

@Component
export struct MyAddIngredientsView {
  build() {
    Column({space:11}) {
      Image($r('app.media.MyAddIngredientsViewB1'))
        .width('100%')
        .height('auto')
        .objectFit(ImageFit.Auto)
        .borderRadius(30)
      Image($r('app.media.MyAddIngredientsViewB2'))
        .width('100%')
        .height('auto')
        .objectFit(ImageFit.Auto)
        .borderRadius(30)

    }
    .width('90%')
    .height('98%')

  }

}
