import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';

@Component
export struct SearchBar {
  @State searchText: string = ''

  build() {
    Row({ space: 11 / PREVIEWER_V_ZOOM }) {
      Image($r('app.media.avatar'))
        .width(50 / PREVIEWER_V_ZOOM)
        .height(50 / PREVIEWER_V_ZOOM)
        .borderRadius(26 / PREVIEWER_V_ZOOM) // 将半径设置为宽度或高度的一半以创建一个圆形

      // .margin({ left: 11 / PREVIEWER_V_ZOOM, right: 11 / PREVIEWER_V_ZOOM })
      Search({ placeholder: '搜索食谱' })
        .onChange((value: string) => {
          this.searchText = value
        })
        .width(300 / PREVIEWER_V_ZOOM)
        .height(47.64 / PREVIEWER_H_ZOOM)
        .border({
          color: Color.Black,
          width: 3,
          radius: 25
        })// .padding({ left: 15, right: 15 })
        .fontColor(Color.Black)
        .placeholderColor(Color.Gray)
        .textAlign(TextAlign.Start)
        .searchButton('搜索', {
          fontSize: 16,
          fontColor: Color.Black
        })
        .backgroundColor('#F5F5F5')// .margin({ left: 11 / PREVIEWER_V_ZOOM, right: 11 / PREVIEWER_V_ZOOM })
        .searchIcon({
          size: 20,
          src: $r('app.media.search_icon')
        })



    }
    .width('100%')
    .height('14%')
    .padding({ top: 24, left: 16 })
    .backgroundImage($r('app.media.SearchBarBackground'))
    .backgroundImageSize({ width: '100%', height: '500%'})
    .backgroundImagePosition({ x:0,y:-400 })

    /**
     * stack
     */
    // Stack() {
    //   Image($r('app.media.SearchBarBackgroundShort'))
    //     .width('100%')
    //
    //     // .height('100%')
    //     .height('100%')
    //     .objectFit(ImageFit.Auto)
    //   Row({ space: 11 / PREVIEWER_V_ZOOM }) {
    //     Image($r('app.media.avatar'))
    //       .width(50 / PREVIEWER_V_ZOOM)
    //       .height(50 / PREVIEWER_V_ZOOM)
    //       .borderRadius(26 / PREVIEWER_V_ZOOM)
    //     Search({ placeholder: '搜索食谱' })
    //       .onChange((value: string) => {
    //         this.searchText = value
    //       })
    //       .width(300 / PREVIEWER_V_ZOOM)
    //       .height(47.64 / PREVIEWER_H_ZOOM)
    //       .border({
    //         color: Color.Black,
    //         width: 3,
    //         radius: 25
    //       })// .padding({ left: 15, right: 15 })
    //       .fontColor(Color.Black)
    //       .placeholderColor(Color.Gray)
    //       .textAlign(TextAlign.Start)
    //       .searchButton('搜索', {
    //         fontSize: 16,
    //         fontColor: Color.Black
    //       })
    //       .backgroundColor('#F5F5F5')// .margin({ left: 11 / PREVIEWER_V_ZOOM, right: 11 / PREVIEWER_V_ZOOM })
    //       .searchIcon({
    //         size: 20,
    //         src: $r('app.media.search_icon')
    //       })
    //
    //   }
    //   .width('100%')
    //   .height('100%')
    //   .padding({ top: 18, left: 16 })
    // }
    // .height('16%')

  }
}