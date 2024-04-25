import { CommonConstants } from '../../constants/CommonConstants';
import router from '@ohos.router';
import { TabItemData } from '../../dataclass/TabItemData';
import { ListDataSource } from '../../viewmodel/datasource/ListDataSource';
import { MainChildItem } from './MainChildItem';
import { ListData } from '../../dataclass/ListData';
import { ServerDataBack } from '../../network/ServerDataBack';
import mainViewModel from '../../viewmodel/MainViewModel';
import { XLog } from '@ohos-port/xlog';
import { CatBreedData } from '../../dataclass/CatBreedData';
import { AxiosError, AxiosResponse } from '@ohos/axios';

import axiosUtils from '../../network/AxiosUtils'


@Preview
@Component
export struct MainChildPage {
  // @Consume('pageInfos') pageInfos: NavPathStack;

  public listDataSource = new ListDataSource()
  @State tabs: Array<TabItemData> = new Array<TabItemData>(new TabItemData("首页", 0), new TabItemData("第二页", 1), new TabItemData("第三页", 2))
  private url: string = ''
  @State getSuccess: boolean = false

  aboutToAppear() {
    this.getListData()
  }

  build() {
    Tabs() {
      ForEach(this.tabs, (item: TabItemData) => {
        if (item.page == 0) {
          TabContent() {
            if (this.getSuccess) {
              List() {
                LazyForEach(this.listDataSource, (childItem: CatBreedData) => {
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
              LazyForEach(this.listDataSource, (childItem: CatBreedData) => {
                ListItem() {
                  this.childItemView(childItem)
                }.width('100%')
              })
            }.width('100%')
            .height('100%')
          }
          .tabBar(item.name)
        } else {
          TabContent() {
          }
          .tabBar(item.name)
        }
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  childItemView(childItem: CatBreedData) {

    // NavDestination() {
    Column() {
      Text(childItem.name) {

      }.width('100%').fontSize(20)

      Text(childItem.id + "") {
      }.width('100%').fontSize(16)

      RelativeContainer() {
        Image($r('app.media.ic_advertise'))
          .width('10%')
          .align(Alignment.End)
          .height('10%')
      }.width('100%')
    }.width('100%')
    .onClick(() => {
      // infos.pushPathByName('pageOne', null)
      router.replaceUrl({
        url: CommonConstants.DETAIL_PAGE_URL,
        params: childItem.id
      })
    })

    // }
  }

  getListData() {
    // 发送get请求
    axiosUtils.instance
      .get<string, AxiosResponse<Array<CatBreedData>>, null>("/breeds?limit=10&page=0")
      .then((response: AxiosResponse) => {
        XLog.i("result:" + JSON.stringify(response.data));

        let result: Array<CatBreedData> = response.data
        if (response.status == 200) {
          this.listDataSource.pushData(result)
        } else {
          // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
        }
        this.getSuccess = true

      })
      .catch((error: AxiosError) => {
        XLog.e("result:" + error.message);
        this.getSuccess = false
      })
      .then(() => {
        //最终执行

      })

  }
}