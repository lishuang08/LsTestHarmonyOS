
import RefreshConstants from '../constants/RefreshConstants'
@Component
export default struct FailureLayout {
  reloadAction = () => {};

  build() {
    Column() {
      Image($r('app.media.ic_none'))
        .height($r('app.float.no_data_img_size'))
        .width($r('app.float.no_data_img_size'))
      Text($r('app.string.page_none_msg'))
        .opacity($r('app.float.no_data_opacity'))
        .fontSize($r('app.float.title_font'))
        .fontColor($r('app.color.title_color'))
        .margin({ top: $r('app.float.common_padding') })
      Text($r('app.string.click_reload'))
        .opacity($r('app.float.no_data_opacity'))
        .fontSize($r('app.float.title_font'))
        .fontColor($r('app.color.color_index'))
        .padding($r('app.float.common_padding'))
        .onClick(this.reloadAction)
    }
    .width(RefreshConstants.FULL_PERCENT)
    .height(RefreshConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }
}