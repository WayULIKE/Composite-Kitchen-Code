import { BtnParm } from './BtnParm'
import { TextParm } from './TextParm'
import { TitleParm } from './TitleParm'
import { WebParm } from './WebParm'

/*
 * @Desc: 全局初始化时的样式和配置。
 * @Author: qincji
 * @Date: 2024/4/19
 * @Email: xhunmon@126.com
 * @OpenSource: https://github.com/xhunmon/ & https://gitee.com/qincji/
 */
export interface HintStyle {
  /**
   * 点击外面区域是否可以取消，默认 true。
   */
  outsideCancel?: boolean
  /**
   * 点击系统返回键可以取消吗，默认 true。
   */
  pressBackCancel?: boolean
  /**
   * 位置
   */
  alignment?: Alignment
  /**
   * 标题的样式
   */
  titleParm?: TitleParm
  /**
   * text加载内容的样式
   */
  textParm?: TextParm
  /**
   * web加载内容的样式
   */
  webParm?: WebParm
  /**
   * 底部按钮的样式
   */
  btnParm?: BtnParm
  /**
   * 最外层UI的样式，通过该属性设置对话框的背景颜色、圆角、距离屏幕的距离等。
   */
  outBoxAttr?: AttributeModifier<ColumnAttribute>
  /**
   * 标题下面的线条样式
   */
  lineStyleTop?: AttributeModifier<LineAttribute>
  /**
   * 内容下面的线条样式
   */
  lineStyleBottom?: AttributeModifier<LineAttribute>
}