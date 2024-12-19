/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { display } from '@kit.ArkUI';
import Constants from '../../../../../cardswiperanimation/src/main/ets/utils/Constants';
import { MyIngredient } from '../model/MyIngredientModel';

/**
 * 卡片组件的实现。
 */
@Component
export default struct MyIngredientCardComponent {
  // 卡片数据，默认初始化
  cardInfo: MyIngredient = {
    name: '添加食材',
    IngredientsImage: $r('app.media.MineMyIngredientsAddButton'),
    width: 120,
    height: 120
  };
  @State cardWith: number = this.cardInfo.width;
  @State cardHeight: number = this.cardInfo.height;
  @State isTablet: boolean = false;
  @State screenW: number = px2vp(display.getDefaultDisplaySync().width);
  private readonly DEVICESIZE: number = 600;
  // 依据Navigation的mode属性说明，如使用Auto，窗口宽度>=600vp时，采用Split模式显示；窗口宽度<600vp时，采用Stack模式显示。
  // 卡片偏移量
  @Prop cardOffset: number = 0;
  // 图片预览窗口是否出现的标志位
  @State private isPhotoShow: boolean = false;
  // 当前卡片的序号
  cardIndex: number = 0;
  // Swiper 当前显示的卡片序号
  @Prop showingCard: number = 0;

  aboutToAppear(): void {
    if ((display.isFoldable() && display.getFoldStatus() === display.FoldStatus.FOLD_STATUS_EXPANDED) ||
      this.screenW >= this.DEVICESIZE) {
      this.isTablet = true;
    } else {
      this.isTablet = false;
    }
    this.cardWith = this.cardInfo.width;
    this.cardHeight = this.cardInfo.height;
  }

  build() {
    Row() {
      Image(this.cardInfo.IngredientsImage)
        .width(this.cardIndex == this.showingCard ? this.cardWith : this.cardWith * 9 / 11)
        .height(this.cardIndex == this.showingCard ? this.cardHeight : this.cardHeight * 9 / 11)
        .offset({
          y: this.cardIndex == this.showingCard ? 0 :
            this.cardHeight * ((this.cardIndex - this.showingCard) > 0 ? this.cardIndex - this.showingCard :
              this.showingCard - this.cardIndex) * 1 / 6
        })
        .objectFit(ImageFit.Cover)
        .borderRadius(12)// TODO 知识点：geometryTransition通过id参数绑定两个组件转场关系，实现一镜到底动画
        .geometryTransition(this.cardIndex.toString(), { follow: true })
        .margin({
          left: this.cardIndex == this.showingCard ? this.cardOffset : this.cardOffset + this.cardHeight * 1 / 11
        })
        .animation({
          curve: Curve.Friction,
          duration: Constants.DURATION
        })
        .onClick(() => {
          if (JSON.stringify(this.cardInfo.IngredientsImage)===JSON.stringify($r('app.media.MineMyIngredientsAddButton'))){
            AppStorage.setOrCreate('MineCurrentStep','MyAddIngredientsView')
            // AppStorage.setOrCreate('MineHaveSearchBar',true)
          }
          // 使点击Swiper两侧的图片无效
          if (this.cardIndex !== this.showingCard) {
            return;
          }
          // 动画及显示预览窗口
          this.animateFunc();
          // console.log('???' +JSON.stringify(this.cardInfo.IngredientsImage))
        })

        .onTouch((event) => {
          if (event) {
            if (event.type === TouchType.Down) {
              // 按下略微缩小
              this.cardWith = this.cardInfo.width * 0.9;
              this.cardHeight = this.cardInfo.height * 0.9;
            } else if (event.type === TouchType.Up) {
              // 抬起恢复大小
              this.cardWith = this.cardInfo.width;
              this.cardHeight = this.cardInfo.height;
            }
          }
        })
        .backgroundColor('#8598B0')
        .borderRadius(18)
      // .bindContentCover(
      //   this.isPhotoShow,
      //   this.photoShowBuilder(this.cardInfo.IngredientsImage, this.cardIndex.toString()),
      //   {
      //     backgroundColor: $r('app.color.photo_preview_build_background'),
      //     modalTransition: ModalTransition.ALPHA,
      //     transition: TransitionEffect.OPACITY.animation({
      //       duration: Constants.DURATION, curve: Curve.Friction
      //     })
      //   }
      // )
      // .shadow({
      //   radius: 35,
      //   type: ShadowType.COLOR,
      //   color: "#ABAAAA",
      //   offsetX: 8,
      //   offsetY: 12
      // })
    }
    .alignItems(VerticalAlign.Center)

  }

  @Builder
  photoShowBuilder(img: ResourceStr, id: string) {
    Column() {
      Image(img)
        .borderRadius(8)
        .geometryTransition(id, { follow: true })
        .width(this.isTablet ? '45%' : '90%')
        .transition(TransitionEffect.opacity(Constants.OPACITY))
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.animateFunc();
    })
    .transition(TransitionEffect.OPACITY.animation({
      duration: Constants.DURATION, curve: Curve.Friction
    }))
  }

  animateFunc() {
    animateTo({
      duration: Constants.DURATION,
      curve: Curve.Friction
    }, () => {
      this.isPhotoShow = !this.isPhotoShow;
    })
  }
}