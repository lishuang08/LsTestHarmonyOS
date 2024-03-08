import { CommonConstants } from '../constants/CommonConstants';
import router from '@ohos.router';
import Logger from '../util/Logger';

@Entry
@Component
struct DetailPage {
  private url: string = ''

  aboutToAppear() {
    this.url = router.getParams()['urlStr']
    Logger.info("this.url " + this.url)
  }

  build() {
    Row() {
      Column() {
        Image( this.url)
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}