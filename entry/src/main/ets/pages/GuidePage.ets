import { CommonConstants } from '../constants/CommonConstants';
import { ServerDataBack } from '../network/ServerDataBack';
import { CatData } from '../dataclass/CatData';
import { CatDataSource } from '../viewmodel/datasource/CatDataSource';
import { ListData } from '../dataclass/ListData';
import startAppViewModel from '../viewmodel/StartAppViewModel';
import router from '@ohos.router';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios';
import url from '@ohos.url';
import { XLog } from '@ohos-port/xlog';
import singleAxios from '../network/AxiosUtils'


@Entry
@Component
struct GuidePage {
  @State private getSuccess: boolean = false
  private swiperController: SwiperController = new SwiperController()
  public dataSource = new CatDataSource()
  public list = new Array<CatData>()

  build() {
    Column() {
      if (this.getSuccess) {
        Swiper() {
          ForEach(this.list, (item: CatData) => {
            Image(item.url)
              .width('100%')
              .height('100%')
              .onClick(() => {
                router.replaceUrl({
                  url: CommonConstants.MAIN_PAGE_URL
                });
              })
          }, (item: CatData, index?: number) => "" + item.url + index)
        }.width('100%')
        .height('100%')
        .loop(true)
      } else {
        Text('正在加载，请稍候')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
    }
  }

  aboutToAppear() {
    XLog.d("aboutToAppear  aaaa")
    // 请求服务端新闻数据
    this.getStartAppData()
  }

  getStartAppData() {

    // let url = "https://jsonplaceholder.typicode.com/posts"

    // let catUrl = "/images/search?limit=10"

    singleAxios.instance
      .get<string, AxiosResponse<Array<CatData>>, null>("/images/search?limit=3")
      .then((response: AxiosResponse) => {
        XLog.i("result:" + response.data);
        let result: Array<CatData> = response.data

        XLog.d(result.toString())

        this.list = result
        // this.dataSource.pushData(result)
        // if (data.success) {
        //
        // } else {
        //   // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
        // }
        this.getSuccess = true
      })
      .catch((error: AxiosError) => {
        XLog.e("result:" + error.message);
        this.getSuccess = false
      })
      .then(() => {
        //最终执行

      })

  };
}