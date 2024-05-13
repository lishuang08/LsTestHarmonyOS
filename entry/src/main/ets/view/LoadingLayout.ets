import RefreshConstants from '../constants/RefreshConstants'

@Component
export default struct LoadingLayout {
  build() {
    Row() {
      Image($r('app.media.ic_pull_up_load'))
        .width($r('app.float.refresh_img_size'))
        .height($r('app.float.refresh_img_size'))
      Text($r('app.string.pull_up_load_text'))
        .margin({ left: $r('app.float.normal_padding') })
        .fontSize($r('app.float.title_font'))
        .textAlign(TextAlign.Center)
    }
    .width(RefreshConstants.FULL_PERCENT)
    .height(RefreshConstants.CUSTOM_LAYOUT_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }
}