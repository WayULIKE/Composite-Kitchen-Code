
@Component
export struct MyPage {
  build() {
    Column() {
      Text('这是MyPage').fontSize(35)
    }
    .width('100%')
    .height('100%')
  }
}
@Builder
export function MyPageBuilder(name: string, param: Object) {
  MyPage()
}