import { CommonConstants } from '../constants/CommonConstants';
import { httpRequestGet } from '../network/HttpGet';
import { ServerDataBack } from '../network/ServerDataBack';
import Logger from '../util/Logger';
import { CatData } from '../dataclass/CatData';
import { CatDataSource } from '../viewmodel/datasource/CatDataSource';
import { ListData } from '../dataclass/ListData';
import startAppViewModel from '../viewmodel/StartAppViewModel';
import router from '@ohos.router';


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
    Logger.debug("aboutToAppear  aaaa")
    // 请求服务端新闻数据
    this.getStartAppData()
  }

  getStartAppData() {

    // let url = "https://jsonplaceholder.typicode.com/posts"

    let catUrl = "https://api.thecatapi.com/v1/images/search?limit=10"

    httpRequestGet(catUrl).then((data: ServerDataBack) => {

      let result: Array<CatData> = JSON.parse(`${data.data}`)

      Logger.debug(result.toString())

      this.list = result
      // this.dataSource.pushData(result)
      // if (data.success) {
      //
      // } else {
      //   // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
      // }
      this.getSuccess = true
    }).catch(() => {
      this.getSuccess = false
      // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
    });
  };
}