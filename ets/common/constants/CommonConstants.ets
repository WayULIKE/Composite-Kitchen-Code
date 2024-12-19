import { CardInfo } from '../../model/CardModel';

export const PREVIEWER_V_ZOOM: number = 1.1;
export const PREVIEWER_H_ZOOM: number = 1.1;
// export const PREVIEWER_V_ZOOM: number = 1.1;
// export const PREVIEWER_H_ZOOM: number = 1.19;


export default class Constants {
  // 卡片的单位长度，便于设置卡片的比例
  public static readonly CARD_UNIT_LENGTH: number = 120;
  // 卡片列表测试用例
  public static readonly CARD_TEST_CASE: CardInfo[] = [
  // 卡片比例 1 x 1
    { src: $r('app.media.panda'), width: this.CARD_UNIT_LENGTH, height: this.CARD_UNIT_LENGTH },
    // 卡片比例 1 x 2
    { src: $r('app.media.kangaroo'), width: this.CARD_UNIT_LENGTH, height: 2 * this.CARD_UNIT_LENGTH },
    // 卡片比例 2 x 1
    { src: $r('app.media.bear'), width: 2 * this.CARD_UNIT_LENGTH, height: this.CARD_UNIT_LENGTH },
    // 卡片比例 2 x 2
    { src: $r('app.media.parrot'), width: 2 * this.CARD_UNIT_LENGTH, height: 2 * this.CARD_UNIT_LENGTH },
  ];
  // Swiper 的偏移量
  public static readonly SWIPER_MARGIN: number = 25;
  // 图片动画透明度值
  public static readonly OPACITY: number = 0.99;
  // 图片动画时长
  public static readonly DURATION: number = 280;
}