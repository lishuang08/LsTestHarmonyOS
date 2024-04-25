import { XLog } from  '@ohos-port/xlog';
import { TabItemData } from '../../dataclass/TabItemData';


@Component
export struct SecondChildPage {
  @State tabs: Array<TabItemData> = new Array<TabItemData>(new TabItemData("1" , 0),)
  private url: string = ''

  aboutToAppear() {
    XLog.i("this.url " + this.url)
  }

  build() {
    Tabs() {
      ForEach(this.tabs, (item: TabItemData) => {
        TabContent(){
          Text(item.name)
            .width('100%')
            .height('100%')
        }.tabBar(item.name)
      })
    }.width('100%')
    .height('100%')
  }
}