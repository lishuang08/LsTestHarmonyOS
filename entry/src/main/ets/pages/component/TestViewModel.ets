import { CommonConstants } from '../../constants/CommonConstants';
import router from '@ohos.router';
import Logger from '../../util/Logger';
import { TabItemData } from '../../dataclass/TabItemData';
import { CatData } from '../../dataclass/CatData';
import { ListData } from '../../dataclass/ListData';

@Component
export struct TestViewModel {
  @State item: ListData = new  ListData()

  constructor(data: ListData) {
    super();
    this.item = data

    Logger.info("aaa " +data.title)
  }

  aboutToAppear() {
  }

  build() {
    Column() {
      Text(this.item.title) {

      }.width('100%').fontSize(20)

      Text(this.item.body) {
      }.width('100%').fontSize(16)
    }.width('100%')

  }
}