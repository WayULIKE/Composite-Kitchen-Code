/*
 * @Desc: 控制标题的样式和内容。
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
export class TitleParm {
  title: string
  noTitle: boolean = false;
  attrModifier: AttributeModifier<TextAttribute>;

  constructor(title: string = '温馨提示', attrModifier: AttributeModifier<TextAttribute> = {}) {
    this.title = title
    this.attrModifier = attrModifier
  }

  setNoTitle() {
    this.noTitle = true;
    return this;
  }
}
