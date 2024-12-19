@Component
export struct CookingProcessView {
  controller: VideoController = new VideoController()
  private previewUris: Resource = $r('app.media.logoWhiteBack');
  // private innerResource: Resource = $rawfile('0001-0102.mov');
  private innerResource: Resource = $rawfile('154_1730896342.mp4');
  private videoTime: number = 4.5;
  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'mm:ss.SS'
  @State count: number = 3 * 60 * 1000
  @State nowVideoTime: number = this.count
  @State XOffset: number = 0

  build() {
    Column({ space: 6 }) {
      TextTimer({ isCountDown: true, count: this.count, controller: this.textTimerController })
        .format(this.format)
        .fontColor(Color.Black)
        .fontSize(60)
        .onTimer((utc: number, elapsedTime: number) => {
          console.info('textTimer notCountDown utc is：' + utc + ', elapsedTime: ' + elapsedTime)
          this.controller.setCurrentTime((elapsedTime / this.count) * this.videoTime * 10, SeekMode.Accurate)
          console.info('textTimer elapsedTime / this.count is：' + elapsedTime / this.count * 10 + ', elapsedTime: ' +
            (elapsedTime / this.count) * this.videoTime * 10)
        })
      Row({ space: 6 }) {
        Button("start").onClick(() => {
          this.textTimerController.start()
          this.controller.start() // 开始播放

        })
          .backgroundColor(Color.White)
          .shadow(ShadowStyle.OUTER_DEFAULT_XS)
          .fontColor(Color.Black)
        Button("pause").onClick(() => {
          this.textTimerController.pause()
          this.controller.pause() // 暂停播放
        })
          .backgroundColor(Color.White)
          .shadow(ShadowStyle.OUTER_DEFAULT_XS)
          .fontColor(Color.Black)
        Button("reset").onClick(() => {
          this.textTimerController.reset()
          this.controller.reset() // 重置AVPlayer
        })
          .backgroundColor(Color.White)
          .shadow(ShadowStyle.OUTER_DEFAULT_XS)
          .fontColor(Color.Black)
      }


      Video({
        src: this.innerResource,
        previewUri: this.previewUris,
        controller: this.controller
      })
        .objectFit(ImageFit.Auto)
        .width('100%')
        .height('40%')
        .offset({ x: this.XOffset })
        .onStart(() => {
          this.XOffset = 100
          console.log('开始了')
        })
        .onSeeked((e?: TimeObject) => {
          if (e != undefined) {
            console.info('onSeeked is ' + e.time)
          }
        })
        .backgroundColor(Color.White)
        .controls(false)
      Text('热锅加油，炒鸡蛋')
        .fontSize(60)
        .padding(6)
        .maxLines(5)


    }
    .padding({ top: 8 })
  }
}

interface TimeObject {
  time: number;
}