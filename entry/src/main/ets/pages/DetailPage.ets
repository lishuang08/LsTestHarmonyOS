import { CommonConstants } from '../constants/CommonConstants';
import router from '@ohos.router';

import common from '@ohos.app.ability.common';
import { MyLog } from '../util/MyLog';

@Entry
@Component
struct DetailPage {
  private catId : number = 0
  private ctx = getContext(this) as common.UIAbilityContext

  aboutToAppear() {
    this.catId = router.getParams() as number
    MyLog.i("this.id  " + this.id )

  }

  build() {
    Row() {
      Column() {

        // Image(this.url)
        //   .width('100%')
        //   .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}