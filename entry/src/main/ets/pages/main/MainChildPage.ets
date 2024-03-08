import { CommonConstants } from '../../constants/CommonConstants';
import router from '@ohos.router';
import Logger from '../../util/Logger';
import { TabItemData } from '../../dataclass/TabItemData';
import { ListDataSource } from '../../viewmodel/datasource/ListDataSource';
import { MainChildItem } from './MainChildItem';
import { ListData } from '../../dataclass/ListData';
import { httpRequestGet } from '../../network/HttpGet';
import { ServerDataBack } from '../../network/ServerDataBack';
import mainViewModel from '../../viewmodel/MainViewModel';

@Component
export struct MainChildPage {
  public listDataSource = new ListDataSource()
  @State tabs: Array<TabItemData> = new Array<TabItemData>(new TabItemData("首页", 0), new TabItemData("第二页", 1), new TabItemData("第三页", 2))
  private url: string = ''
  @State getListSuccess: boolean = false

  aboutToAppear() {
    Logger.info("this.url " + this.url)
    mainViewModel.getListData(this.listDataSource,   this.getListSuccess )
  }

  build() {
    Tabs() {
      ForEach(this.tabs, (item: TabItemData) => {
        if (item.page == 0) {
          TabContent() {
            if (this.getListSuccess) {
              List() {
                LazyForEach(this.listDataSource, (childItem: ListData) => {
                  ListItem() {
                    this.childItemView(childItem)
                  }.width('100%')
                })
              }.width('100%')
              .height('100%')

            } else {
              Text('正在加载，请稍候')
                .width('100%')
                .height('100%')
                .backgroundColor(Color.Gray)
                .textAlign(TextAlign.Center)
                .fontSize(30)
            }
          }.tabBar(item.name)
        } else if (item.page == 1) {
          TabContent() {
            List() {
              LazyForEach(this.listDataSource, (childItem: ListData) => {
                ListItem() {
                  this.childItemView(childItem)
                }.width('100%')
              })
            }.width('100%')
            .height('100%')
          }
          .tabBar(item.name)
        }

        else {
          TabContent() {

          }

          .tabBar(item.name)
        }

      }
      )
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  childItemView(childItem: ListData) {
    Column() {
      Text(childItem.title) {

      }.width('100%').fontSize(20)

      Text(childItem.body) {
      }.width('100%').fontSize(16)

      RelativeContainer() {
        Text(childItem.userId.toString()) {

        }.width('100%').fontSize(20)

        Image($r('app.media.ic_advertise'))
          .width('10%')
          .align(Alignment.End)
          .height('10%')

      }.width('100%')
    }.width('100%')
    .onClick(() => {
      router.replaceUrl({
        url: CommonConstants.MAIN_PAGE_URL
      })
    })
  }
}
