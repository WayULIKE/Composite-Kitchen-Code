import { image } from '@kit.ImageKit'

@Component

export struct HealthRecommendationView {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private img: ImageBitmap =
    new ImageBitmap("common/image/ChooseRecipeRecommendedImage.png")

  // @Builder
  // descriptionBuilder() {
  //   Text('说明文本')
  //     .maxFontSize('30sp')
  //     .minFontSize("10.0vp")
  //     .fontColor("#fffa2a2d")
  //     .fontWeight(FontWeight.Medium)
  //     .width('100%')
  //     .height("100%")
  //     .textAlign(TextAlign.Center)
  // }

  build() {
    Column() {
      Image($r('app.media.HealthRecommendationViewTheFinishedRecipe'))
        .width('98%')
        .height('auto')
        .objectFit(ImageFit.Auto)
        .interpolation(ImageInterpolation.High)
      Image($r('app.media.HealthRecommendationView'))
        .width('90%')
        .height('auto')
        .objectFit(ImageFit.Auto)
        .interpolation(ImageInterpolation.High)

    }
    .width('100%')
    .height('100%')

    // Stack() {
    //
    //   Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
    //     Canvas(this.context)
    //       .width('95%')
    //       .height('95%')
    //       .backgroundColor('#E6FCD4')
    //       .onReady(() => {
    //
    //         //白色背景板
    //         this.context.fillStyle = '#ffffffff'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 150, 0, Math.PI * 2)
    //         this.context.fill()
    //
    //         //最外层绿色圆环
    //         this.context.lineWidth = 20
    //         this.context.strokeStyle = '#35FF3E'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 140, 0, Math.PI)
    //         this.context.stroke()
    //
    //         //最里层元素层-蛋白质
    //         this.context.lineWidth = 25
    //         this.context.strokeStyle = '#67D1FF'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 97.5 + 20, Math.PI * 2 * 0.3, Math.PI * 2 * 0.6)
    //         this.context.stroke()
    //
    //         //最里层元素层-胶原
    //         this.context.lineWidth = 15
    //         this.context.strokeStyle = '#57A5C6'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 90 - 20 * (25 / 40) + 20, Math.PI * 2 * 0.3, Math.PI * 2 * 0.6)
    //         this.context.stroke()
    //
    //
    //         //最里层元素层-钾钠盐
    //         this.context.lineWidth = 40
    //         this.context.strokeStyle = '#FAFF67'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 90 + 20, Math.PI * 2 * 0.6, Math.PI * 2 * 0.7)
    //         this.context.stroke()
    //
    //         //最里层元素层-油脂
    //         this.context.lineWidth = 40
    //         this.context.strokeStyle = '#FF6767'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 90 + 20, Math.PI * 2 * 0.7, Math.PI * 2 * 0.1)
    //         this.context.stroke()
    //
    //         //最里层元素层-碳水
    //         this.context.lineWidth = 40
    //         this.context.strokeStyle = '#FF9067'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 90 + 20, Math.PI * 2 * 0.1, Math.PI * 2 * 0.3)
    //         this.context.stroke()
    //
    //
    //         //最里层白框
    //         this.context.fillStyle = '#ffffffff'
    //         this.context.beginPath()
    //         this.context.arc(190, 180, 50 + 20, 0, Math.PI * 2)
    //         this.context.fill()
    //
    //         this.context.fillStyle = '#ff000000'
    //         this.context.font = '45px sans-serif'
    //         this.context.fillText("缺少摄入", 163, 110)
    //         this.context.font = '45px sans-serif'
    //         this.context.fillText("摄入过多", 163, 150)
    //         this.context.font = '45px sans-serif'
    //         this.context.fillText("为你推荐", 163, 190)
    //
    //         this.context.imageSmoothingEnabled = true
    //         this.context.imageSmoothingQuality = 'high'
    //         this.context.drawImage(this.img, 140, 190, 100, 70)
    //
    //
    //       })
    //
    //   }
    //
    // }
    // .alignContent(Alignment.Center)
    // .width('100%')
    // .height('100%')


  }
}