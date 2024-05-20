import { CommonConstants } from '../../../constants/CommonConstants';
import router from '@ohos.router';
import { TabItemData } from '../../../dataclass/TabItemData';
import { CatData } from '../../../dataclass/CatData';
import { ListData } from '../../../dataclass/ListData';
import { MyLog } from '../../../util/MyLog';
import { CatBreedData } from '../../../dataclass/CatBreedData';
import systemDateTime from '@ohos.systemDateTime';
import worker from '@ohos.worker';
import { EmitterEventData } from '../../../dataclass/EmitterEventData';
import emitter from '@ohos.events.emitter';


// 定义在全局的@Styles封装的样式
@Styles
function imageStyle() {
  .width(48)
  .height(48)
  // .backgroundColor(Color.Pink)
}

@Component
export struct CatItemView {
  @Prop item: CatData = new CatData()

  aboutToAppear() {


    MyLog.e("item  fileUri :" + this.item.fileUri)
  }



  build() {
    Row() {
      if (this.item.url != null) {
        Image(this.item.fileUri)
          .align(Alignment.Start)
          .imageStyle()
          .alt('/../resources/base/media/ic_default.svg')
          .objectFit(ImageFit.Fill)
          .margin(15)
        // .syncLoad(true) //同步加载图片，会导致加载过慢
      }

      Column() {
        Text(this.item.id) {

        }.width('100%').fontSize(20)

        Text(this.item.id + "") {
        }.width('100%').fontSize(16)
      }.margin(10)

    }.width('100%')
    // 在IconItem内调用renderGroup，true为开启，false为关闭
    // .renderGroup(this.renderGroupFlag)
    .onClick(() => {
      // infos.pushPathByName('pageOne', null)
      router.replaceUrl({
        url: CommonConstants.CAT_BREED_LIST_URL,
        params: this.item.id
      })
    })

    // }

  }
}