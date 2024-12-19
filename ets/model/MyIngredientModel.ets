export interface MyIngredient {
  name: string;
  IngredientsImage: ResourceStr;
  width: number;
  height: number;

  // constructor(name: string, IngredientsImage: ResourceStr,width: number,height: number) {
  //   this.name = name;
  //   this.IngredientsImage = IngredientsImage
  //   this.width = width
  //   this.height = height
  // }
}


/**
 * 保存卡片信息列表的懒加载类。
 */
export class CardsSource implements IDataSource {
  private list: MyIngredient[] = [];

  constructor(list: MyIngredient[]) {
    this.list = list;
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): MyIngredient {
    return this.list[index];
  }

  registerDataChangeListener(): void {
  }

  unregisterDataChangeListener(): void {
  }
}

export default class MyIngredients {
  public static readonly CARD_UNIT_LENGTH: number = 110;
  // 卡片列表测试用例
  public static readonly CARD_TEST_CASE: MyIngredient[] = [
  // 卡片比例 1 x 1
    {
      name: '添加',
      IngredientsImage: $r('app.media.MineMyIngredientsAddButton'),
      width: this.CARD_UNIT_LENGTH,
      height: this.CARD_UNIT_LENGTH
    },
    // 卡片比例 1 x 2
    {
      name: '番茄',
      IngredientsImage: $r('app.media.Tomato'),
      width: this.CARD_UNIT_LENGTH,
      height: this.CARD_UNIT_LENGTH
    },
    // 卡片比例 2 x 1
    {
      name: '西兰花',
      IngredientsImage: $r('app.media.Broccoli'),
      width: this.CARD_UNIT_LENGTH,
      height: this.CARD_UNIT_LENGTH
    },
    {
      name: '鸡蛋',
      IngredientsImage: $r('app.media.Egg'),
      width: this.CARD_UNIT_LENGTH,
      height: this.CARD_UNIT_LENGTH
    },
  // // 卡片比例 2 x 2
  // { name:'鹦鹉',IngredientsImage: $r('app.media.parrot'), width: 240, height: 240 },
  ];

}
