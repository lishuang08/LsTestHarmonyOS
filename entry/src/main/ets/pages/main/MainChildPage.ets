import { CommonConstants } from '../../constants/CommonConstants';
import router from '@ohos.router';
import { TabItemData } from '../../dataclass/TabItemData';
import { CatBreedSource } from '../../datasource/CatBreedSource';
import { MainChildItem } from './MainChildItem';
import { ListData } from '../../dataclass/ListData';
import { ServerDataBack } from '../../network/ServerDataBack';
import { CatBreedData } from '../../dataclass/CatBreedData';
import { AxiosError, AxiosResponse } from '@ohos/axios';

import axiosUtils from '../../network/AxiosUtils'
import { SecondChildPage } from './SecondChildPage';
import { WebPage } from '../WebPage';
import HashMap from '@ohos.util.HashMap';
import FaultLogger from '@ohos.faultLogger';
import { MyLog } from '../../util/MyLog';

import { PullToRefresh } from "./../../lib/PullToRefresh/PullToRefresh"
import { CatData } from '../../dataclass/CatData';
import { MainRefreshView } from './MainRefreshView';
import CatDataViewModel from '../../viewmodel/CatDataViewModel';
import catVm from '../../viewmodel/CatDataViewModel';
import ArrayList from '@ohos.util.ArrayList';

@Preview
@Component
export struct MainChildPage {
  // public listDataSource = new ListDataSource()
  public listDataSource = new CatBreedSource()

  @State currentIndex: number = 0;

  @State getSuccess: boolean = false
  @State tabs: Array<TabItemData> = new Array<TabItemData>(new TabItemData("首页", 0), new TabItemData("第二页", 1), new TabItemData("第三页", 2))
  @State isRefreshing: boolean = false
  counter = 0
  private scroller = new Scroller()

  private tabsController : TabsController = new TabsController()

  // @State arrlist :Array<CatBreedData>  = new Array<CatBreedData>()

  aboutToAppear() {
    // this.getListData()
    this.getData()
  }

  getData() {
    catVm.getListDataPromise().then((response: AxiosResponse) => {
      MyLog.i("result:" + JSON.stringify(response.data));
      let result: Array<CatBreedData> = response.data
      if (response.status == 200) {
        this.listDataSource.setData(result)
        // this. arrlist = result
      } else {
        // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
      }
      this.getSuccess = true
    })
      .catch((error: AxiosError) => {
        MyLog.e("result:" + error.message);
        this.getSuccess = false
      })
      .then(() => {
        //最终执行
      })
  }

  build() {
    Tabs() {
      ForEach(this.tabs, (item: TabItemData) => {
        if (item.page == 0) {
          TabContent() {
            // Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
            if (this.getSuccess) {
              // this.mainListView()

              // PullToRefresh({
              //   // 必传项，列表组件所绑定的数据
              //   // data: $(catVm.listDataSource),
              //   // 必传项，需绑定传入主体布局内的列表或宫格组件
              //   scroller: this.scroller,
              //   // 必传项，自定义主体布局，内部有列表或宫格组件
              //   customList: () => {
                  // 一个用@Builder修饰过的UI方法
                  this.mainListView();
              //   },
              //   // 可选项，下拉刷新回调
              //   onRefresh: () => {
              //     return new Promise<string>((resolve, reject) => {
              //       // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
              //       setTimeout(() => {
              //         resolve('刷新成功');
              //         // this.data = this.dataNumbers;
              //       }, 2000);
              //     });
              //   },
              //   // 可选项，上拉加载更多回调
              //   onLoadMore: () => {
              //     return new Promise<string>((resolve, reject) => {
              //       // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
              //       setTimeout(() => {
              //         resolve('');
              //         // this.data.push("增加的条目" + this.data.length);
              //       }, 2000);
              //     });
              //   },
              //   customLoad: null,
              //   customRefresh: null,
              // })


            } else {
              Text('正在加载，请稍候')
                .width('100%')
                .height('100%')
                .backgroundColor(Color.Gray)
                .textAlign(TextAlign.Center)
                .fontSize(30)
            }
            // }
            // .onStateChange((refreshStatus: RefreshStatus) => {
            //   MyLog.e('Refresh onStatueChange state is ' + refreshStatus     +"    this.isRefreshing :" + this.isRefreshing)
            // })
            // .onRefreshing(() => {
            //   setTimeout(() => {
            //     this.counter++
            //     this.isRefreshing = false
            //   }, 3000)
            //   MyLog.e('onRefreshing test')
            // })
            // .width('100%')
            // .height('100%')
          }.tabBar(item.name)
        } else if (item.page == 1) {
          TabContent() {
            MainRefreshView({currentIndex: $currentIndex})
          }
          .tabBar(item.name)
        } else {
          TabContent() {
            WebPage()
          }
          .tabBar(item.name)
        }
      })
    }
    .onChange((index) => {
      this.currentIndex = index
    })
    .width('100%')
    .height('100%')
  }

  @Builder
  mainListView() {
    List() {

      LazyForEach(this .listDataSource, (childItem: CatBreedData) => {
        ListItem() {
          MainChildItem({item :childItem})
        }.width('100%')
      })
    }
    .cachedCount(3) // 缓存3个
    .width('100%')
    .height('100%')
    .onTouch((event?: TouchEvent) => {
      // if (event) {
      //   MyLog.e("")
      // }
    })

    // .onScrollFrameBegin((offset, state) => {
    //   //设置为0 ,禁止滑动
    //   return { offsetRemain: 0 }
    // })
  }

}