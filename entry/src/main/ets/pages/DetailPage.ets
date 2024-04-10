import { CommonConstants } from '../constants/CommonConstants';
import router from '@ohos.router';
import Logger from '../util/Logger';

import common from '@ohos.app.ability.common';

let globalDataShare;


@Entry
@Component
struct DetailPage {
  private url: string = ''
  private ctx = getContext(this) as common.UIAbilityContext

  aboutToAppear() {
    this.ctx.eventHub.on("接收",(...data) => {
      // 触发事件，完成相应的业务操作
      console.info("tag", '2. ' + JSON.stringify(data));
    })
    globalDataShare = globalThis.globalDataShare


    this.url = router.getParams()['urlStr']
    Logger.info("this.url " + this.url)


  }

  build() {
    Row() {
      Column() {

        Image(this.url)
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