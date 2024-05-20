import { CommonConstants } from '../../constants/CommonConstants';
import router from '@ohos.router';
import { TabItemData } from '../../dataclass/TabItemData';
import { CatData } from '../../dataclass/CatData';
import { ListData } from '../../dataclass/ListData';
import { MyLog } from '../../util/MyLog';
import { CatBreedData } from '../../dataclass/CatBreedData';

@Component
export struct MainChildItem {
  item: CatBreedData = new CatBreedData()

  build() {
    Row() {
      if (this.item.image != null) {
        Image(this.item.image.url)
          .width(56)
          .align(Alignment.Start)
          .alt('/../resources/base/media/ic_default.svg')
          .height(56)// .syncLoad(true) //同步加载图片，会导致加载过慢
          .objectFit(ImageFit.Fill)
          .margin(15)
      }

      Column() {
        Text(this.item.name) {

        }.width('100%').fontSize(20)

        Text(this.item.id + "") {
        }.width('100%').fontSize(16)
      }.margin(10)

    }.width('100%')
    .onClick(() => {
      // infos.pushPathByName('pageOne', null)

      MyLog.e("click  : " + this.item.id)

      router.pushUrl({
        url: CommonConstants.CAT_BREED_LIST_URL,
        params: {
          breedid: this.item.id
        }
      })
    })

    // }

  }
}