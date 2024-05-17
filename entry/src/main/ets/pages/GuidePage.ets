import { CommonConstants } from '../constants/CommonConstants';
import { ServerDataBack } from '../network/ServerDataBack';
import { CatData } from '../dataclass/CatData';
import { CatDataSource } from '../datasource/CatDataSource';
import { ListData } from '../dataclass/ListData';
import startAppViewModel from '../viewmodel/StartAppViewModel';
import router from '@ohos.router';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios';
import axiosUtils from '../network/AxiosUtils'
import { MyLog } from '../util/MyLog';
import taskpool from '@ohos.taskpool';
import request from '@ohos.request';


@Entry
@Component
struct GuidePage {
  @State private getSuccess: boolean = false
  private swiperController: SwiperController = new SwiperController()
  public dataSource = new CatDataSource()
  public list = new Array<CatData>()

  downImage(imgUrl: string) {
    let downloadTask;
    try {
      request.downloadFile(globalThis.abilityContext, { url: imgUrl,
        header :{
           'x-api-key'   :  "live_aK46UpThibgCvmIMnpvB38RYj9XFiDnqJFdypXUG2SnK8AviL3u1X2V22d7MsLZl"
        } ,
        filePath: 'xxx/xxxxx.hap'}, (err, data) => {
        if (err) {
          console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
          return;
        }
        downloadTask = data;
      });
    } catch (err) {
      console.error('err.code : ' + err.code + ', err.message : ' + err.message);
    }
  }

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
    MyLog.d("aboutToAppear  aaaa")
    // 请求服务端新闻数据
    this.getStartAppData()
  }

  getStartAppData() {

    // let url = "https://jsonplaceholder.typicode.com/posts"

    // let catUrl = "/images/search?limit=10"

    axiosUtils.instance
      .get<string, AxiosResponse<Array<CatData>>, null>("/images/search?limit=3")
      .then((response: AxiosResponse) => {
        MyLog.i("result:" + response.data);
        let result: Array<CatData> = response.data

        MyLog.d(result.toString())

        this.list = result

        // result.forEach((item: CatData) => {
        //   let task: taskpool.Task = new taskpool.Task(this.downImage, item.url);
        //   await taskpool.execute(task)
        //
        // })
        // this.dataSource.pushData(result)
        // if (data.success) {
        //
        // } else {
        //   // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
        // }


        this.getSuccess = true
      })
      .catch((error: AxiosError) => {
        MyLog.e("result:" + error.message);
        this.getSuccess = false
      })
      .then(() => {
        //最终执行

      })

  };
}