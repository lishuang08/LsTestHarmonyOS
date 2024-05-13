
import RefreshConstants from '../constants/RefreshConstants';
import RefreshLoadingClass from '../viewmodel/RefreshLoadingClass';

@Component
export default struct LoadMoreLayout {
  @Prop  loadMoreLayoutClass: RefreshLoadingClass;

  build() {
    Row() {
      Image(this.loadMoreLayoutClass.imageSrc)
        .width($r('app.float.refresh_img_size'))
        .height($r('app.float.refresh_img_size'))

      Text(this.loadMoreLayoutClass.textValue)
        .margin({ left: $r('app.float.normal_padding') })
        .fontSize($r('app.float.title_font'))
        .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width(RefreshConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .height(this.loadMoreLayoutClass.heightValue)
  }
}