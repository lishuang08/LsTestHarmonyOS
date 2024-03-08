import router from '@ohos.router';
import CopyrightComponent from '../view/CopyrightComponent';
import { CommonConstants } from '../constants/CommonConstants';

@Entry
@Component
struct SplashScreenPage {
  @State pageShowTime: number = CommonConstants.TIME_DEFAULT_VALUE;
  @State intervalID: number = CommonConstants.INTERVAL_ID_DEFAULT;

  build() {
    Column() {
      Image($r('app.media.app_icon'))
        .objectFit(ImageFit.Contain)
        .align(Alignment.Bottom)
        .width('50%')
        .height('50%')

      Image($r('app.media.app_icon')).width('50%').margin('20%')
    }
    .justifyContent(FlexAlign.End)
    .backgroundColor($r('app.color.launcher_background'))
    .width(CommonConstants.COLUMN_WIDTH)
    .height(CommonConstants.COLUMN_HEIGHT)
  }

  aboutToAppear(){
  }

  /**
   * When the SplashScreenPage is displayed, switch to the next page after 3 seconds.
   */
  onPageShow() {
    // this.intervalID = setInterval(() => {
    //   this.pageShowTime += CommonConstants.INCREMENT_VALUE;
    //   if (this.pageShowTime > CommonConstants.DELAY_SECONDS) {
        router.replaceUrl({
          url: CommonConstants.GUIDE_PAGE_URL
        });
    //   }
    // }, CommonConstants.INTERVAL_DELAY);
  }

  /**
   * When the SplashScreenPage is hide, clear interval.
   */
  onPageHide() {
    clearInterval(this.intervalID);
  }
}

@Component
struct SkipButton {
  @Prop secondsCount: number;

  build() {
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.End
    }) {
      Text($r('app.string.skip', this.secondsCount))
        .backgroundColor($r('app.color.rect_area_background'))
        .borderRadius(CommonConstants.SKIP_BUTTON_RADIUS)
        .fontColor(Color.White)
        .width($r('app.float.skip_text_width'))
        .height($r('app.float.skip_text_height'))
        .fontSize($r('app.float.skip_text_size'))
        .margin({
          right: $r('app.float.skip_text_margin_right'),
          top: $r('app.float.skip_text_margin_top')
        })
        .textAlign(TextAlign.Center)
        .border({ width: CommonConstants.SKIP_TEXT_BORDER_WIDTH })
        .borderColor($r('app.color.rect_stroke'))
        .onClick(() => {
          router.replaceUrl({
            url: CommonConstants.MAIN_PAGE_URL
          });
        })
    }
  }
}

