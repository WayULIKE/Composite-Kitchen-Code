/*
 * @Desc: 中间text参数。
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
export class TextParm {
  content: string
  attrModifier: AttributeModifier<TextAttribute>;

  constructor(content: string, attrModifier: AttributeModifier<TextAttribute> = {}) {
    this.content = content;
    this.attrModifier = attrModifier;
  }
}
