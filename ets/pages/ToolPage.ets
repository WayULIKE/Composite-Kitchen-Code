
@Component
export struct ToolPage {
  build() {
    Column() {
      Text('ToolPage').fontSize(35)
    }
    .width('100%')
    .height('100%')
  }
}
@Builder
export function ToolPageBuilder(name: string, param: Object) {
  ToolPage()
}