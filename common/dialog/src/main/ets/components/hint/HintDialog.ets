/*
 * @Desc: 
 * @Author: qincji
 * @Date: 2024/6/21
 */
import { HintParm } from './parms/HintParm';
import { HintStyle } from './parms/HintStyle';
import { TitleParm } from './parms/TitleParm';
import { TextParm } from './parms/TextParm';
import { WebParm } from './parms/WebParm';
import { BtnParm } from './parms/BtnParm';
import { CoreDialog } from './dialog/CoreDialog';

@Component
export struct HintDialog {
  private static hintStyle: HintStyle = {};
  @State result: string = "";
  @State backCancel: boolean = true;
  @Provide titleParm: TitleParm | undefined = undefined;
  @Provide textParm: TextParm | undefined = undefined;
  @Provide webParm: WebParm | undefined = undefined;
  @Provide btnParm: BtnParm | undefined = undefined;
  @State outsideCancel: boolean = true;
  @State alignment: Alignment = Alignment.Center;
  @State outBoxAttr: AttributeModifier<ColumnAttribute> | undefined = undefined;
  @State lineTop: AttributeModifier<LineAttribute> | undefined = undefined;
  @State lineBottom: AttributeModifier<LineAttribute> | undefined = undefined;
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Stack() {
        Stack()
          .width('100%')
          .height('100%')
          .onClick(() => {
            if (this.outsideCancel) {
              this.pathStack.pop();
            }
          })
        CoreDialog({
          outBoxAttr: this.outBoxAttr,
          lineStyleTop: this.lineTop,
          lineStyleBottom: this.lineBottom
        })
      }
      .backgroundColor($r('sys.color.mask_secondary'))
      .alignContent(this.alignment)
      .width('100%')
      .height('100%')
    }
    .onReady(cxt => {
      this.pathStack = cxt.pathStack
      const parm = cxt.pathInfo.param as HintParm;
      this.createParm(parm);
    })
    .onBackPressed(() => {
      return !this.backCancel;
    })
    .mode(NavDestinationMode.DIALOG)
    .hideTitleBar(true)
  }

  private createTitleParm(cur: HintParm, deft: TitleParm | undefined) {
    //不显示标题
    if (deft === undefined && cur.noTitle === true) {
      return;
    }
    const parm = new TitleParm();
    if (deft !== undefined) {
      parm.title = deft.title !== undefined ? deft.title : parm.title;
      parm.attrModifier = deft.attrModifier !== undefined ? deft.attrModifier : parm.attrModifier;
    }
    if (cur.title !== undefined) {
      parm.title = cur.title;
    }
    return parm;
  }

  private createTextParm(cur: HintParm, deft: TextParm | undefined) {
    if (deft === undefined && cur.isWebType !== undefined) {
      return;
    }
    const parm = new TextParm('');
    if (deft !== undefined) {
      parm.content = deft.content !== undefined ? deft.content : parm.content;
      parm.attrModifier = deft.attrModifier !== undefined ? deft.attrModifier : parm.attrModifier;
    }
    if (cur.content !== undefined && cur.content !== '') {
      parm.content = cur.content;
    }
    return parm;
  }

  private createWebParm(cur: HintParm, deft: WebParm | undefined) {
    if (deft === undefined && cur.isWebType === undefined) {
      return;
    }
    const parm = new WebParm('');
    if (deft !== undefined) {
      parm.url = deft.url !== undefined ? deft.url : parm.url;
      parm.attrModifier = deft.attrModifier !== undefined ? deft.attrModifier : parm.attrModifier;
    }
    if (cur.content !== undefined && cur.content !== '') {
      parm.url = cur.content;
    }
    parm.controller = cur.controller !== undefined ? cur.controller : parm.controller;
    return parm;
  }

  private createBtnParm(cur: HintParm, deft: BtnParm | undefined) {
    const parm = new BtnParm();
    if (deft !== undefined) {
      parm.showNo = deft.showNo !== undefined ? deft.showNo : parm.showNo;
      parm.noMsg = (deft.noMsg !== undefined && deft.noMsg !== '') ? deft.noMsg : parm.noMsg;
      parm.okMsg = (deft.okMsg !== undefined && deft.okMsg !== '') ? deft.okMsg : parm.okMsg;
      parm.attrNoModifier = deft.attrNoModifier !== undefined ? deft.attrNoModifier : parm.attrNoModifier;
      parm.attrOkModifier = deft.attrOkModifier !== undefined ? deft.attrOkModifier : parm.attrOkModifier;
      parm.attrLineModifier = deft.attrLineModifier !== undefined ? deft.attrLineModifier : parm.attrLineModifier;
    }
    parm.showNo = cur.showNo !== undefined ? cur.showNo : parm.showNo;
    parm.noMsg = (cur.noMsg !== undefined && cur.noMsg !== '') ? cur.noMsg : parm.noMsg;
    parm.okMsg = (cur.okMsg !== undefined && cur.okMsg !== '') ? cur.okMsg : parm.okMsg;
    return parm;
  }

  private createParm(parm: HintParm): void {
    //点击是否可以取消，默认true
    const outC = HintDialog.hintStyle.outsideCancel;
    this.outsideCancel = parm.outsideCancel !== undefined ? parm.outsideCancel : (outC !== undefined ? outC : true);
    const back = HintDialog.hintStyle.pressBackCancel;
    this.backCancel = parm.pressBackCancel !== undefined ? parm.pressBackCancel : (back !== undefined ? back : true);
    //位置
    const ali = HintDialog.hintStyle.alignment;
    this.alignment = parm.alignment !== undefined ? parm.alignment : (ali !== undefined ? ali : Alignment.Center);

    this.titleParm = this.createTitleParm(parm, HintDialog.hintStyle.titleParm)
    this.textParm = this.createTextParm(parm, HintDialog.hintStyle.textParm)
    this.webParm = this.createWebParm(parm, HintDialog.hintStyle.webParm)
    this.btnParm = this.createBtnParm(parm, HintDialog.hintStyle.btnParm)

    //最外层样式
    const outBA = HintDialog.hintStyle.outBoxAttr;
    this.outBoxAttr = outBA !== undefined ? outBA : {};
    const lineTop = HintDialog.hintStyle.lineStyleTop;
    if (this.titleParm === undefined) { //不显示标题的情况下，顶部的线也没有必要存在
      this.lineTop = {
        applyNormalAttribute(instance: LineAttribute) {
          instance.visibility(Visibility.None)
        }
      }
    } else {
      this.lineTop = lineTop !== undefined ? lineTop : {};
    }
    const lineBottom = HintDialog.hintStyle.lineStyleBottom;
    this.lineBottom = lineBottom !== undefined ? lineBottom : {};

    //以下是处理按钮的点击事件
    let onNo = this.btnParm.onNo;
    let onOk = this.btnParm.onOk;
    if (parm.onNo !== undefined) {
      onNo = parm.onNo;
    }
    if (parm.onOk !== undefined) {
      onOk = parm.onOk;
    }
    const proxyOnNo = () => {
      this.pathStack.pop();
      onNo?.();
    };
    this.btnParm.bOnNo(proxyOnNo)
    this.btnParm.bOnOk(() => {
      this.pathStack.pop();
      onOk?.();
    })
  }

  /**
   * 全局初始化样式
   */
  static initDefaultStyle(hintStyle: HintStyle) {
    HintDialog.hintStyle = hintStyle;
  }
}

@Builder
export function RegisterBuilder(): void {
  HintDialog();
}