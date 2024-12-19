@Component
@Preview
export struct FoodAssociationComponent {
  @Link currentSwiperIndex: number;
  AssociationOffsetX0: number = 0
  AssociationOffsetX1: number = 0
  AssociationOffsetX2: number = 0
  AssociationOffsetY0: number = 0
  AssociationOffsetY1: number = 0
  AssociationOffsetY2: number = 0

  aboutToAppear(): void {
    console.log(this.AssociationOffsetX0 + '????')
    this.AssociationOffsetX0 = 100
    this.AssociationOffsetX1 = -100
    this.AssociationOffsetX2 = 50
    this.AssociationOffsetY0 = 100
    this.AssociationOffsetY1 = -100
    this.AssociationOffsetY2 = -100
    console.log(this.AssociationOffsetX0 + '????')
  }

  build() {

    Column() {
      Stack() {
        if (this.currentSwiperIndex == 1) {

          // Row(){
          Text('与番茄有最多搭配的食材')
            .offset({ x: 0, y: -200 })

          // }
          // .height('5%')


          Image($r('app.media.Eggplants'))
            .offset({ x: this.AssociationOffsetX0, y: this.AssociationOffsetY0 })
            .width(80)
            .height(80)
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .borderRadius(40)

          // .animation({
          //   duration: 100000,
          //   curve: Curve.EaseInOut,
          //   iterations: 1,
          //   playMode: PlayMode.Alternate,
          //
          // })
          Image($r('app.media.Egg'))
            .borderRadius(40)
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .offset({ x: this.AssociationOffsetX1, y: this.AssociationOffsetY1 })
            .width(80)
            .height(80)
            .onClick(()=>{
              AppStorage.setOrCreate("MineCurrentStep","MyConnectionView")
            })
          Image($r('app.media.Salmon'))
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .borderRadius(40)
            .offset({ x: this.AssociationOffsetX2, y: this.AssociationOffsetY2 })
            .width(80)
            .height(80)
            .objectFit(ImageFit.Auto)
          Image($r('app.media.Tomato'))
            .borderRadius(50)
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .width(100)
            .height(100)


        } else if (this.currentSwiperIndex == 2) {


          Text('与西兰花有最多搭配的食材')

            .offset({ x: 0, y: -200 })

          Image($r('app.media.carrot'))
            .borderRadius(40)
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .offset({ x: this.AssociationOffsetX1, y: this.AssociationOffsetY1 })
            .width(80)
            .height(80)
          Image($r('app.media.msrm'))
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .borderRadius(40)
            .offset({ x: this.AssociationOffsetX2, y: this.AssociationOffsetY2 })
            .width(80)
            .height(80)
            .objectFit(ImageFit.Auto)
          Image($r('app.media.Broccoli'))
            .borderRadius(50)
            .shadow(ShadowStyle.OUTER_DEFAULT_SM)
            .width(100)
            .height(100)


          // .animation({
          //   duration: 100000,
          //   curve: Curve.EaseInOut,
          //   iterations: 1,
          //   playMode: PlayMode.Alternate,
          //
          // })

        }
      }
    }
    .width
    ('100%'
    )
    .height
    ('100%'
    )
    .alignItems
    (HorizontalAlign
      .Center
    )
    .justifyContent
    (FlexAlign
      .Center
    )
    .animation({
      duration: 300,
      curve: Curve.EaseInOut,
      iterations: 1,
      playMode: PlayMode.Alternate,

    })
  }
}
