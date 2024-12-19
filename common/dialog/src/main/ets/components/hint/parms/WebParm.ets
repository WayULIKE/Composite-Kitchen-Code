import web_webview from '@ohos.web.webview'

/*
 * @Desc: 控制标题的样式和内容。
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
export class WebParm {
  url: string;
  attrModifier: AttributeModifier<WebAttribute>;
  controller: WebviewController;

  constructor(url: string, attrModifier: AttributeModifier<WebAttribute> = {},
              controller: WebviewController = new web_webview.WebviewController()) {
    this.url = url;
    this.attrModifier = attrModifier;
    this.controller = controller;
  }
}