import catVm from '../../../viewmodel/CatDataViewModel'
import router from '@ohos.router'
import { MyLog } from '../../../util/MyLog'
import { CatData } from '../../../dataclass/CatData'
import { AxiosError, AxiosResponse } from '@ohos/axios';
import { PullToRefresh } from '../../../lib/PullToRefresh/PullToRefresh'
import { CatBreedSource } from '../../../datasource/CatBreedSource'
import { CatDataSource } from '../../../datasource/CatDataSource'
import { CatItemView } from './CatItemView'
import taskpool from '@ohos.taskpool'
import http from '@ohos.net.http'
import request from '@ohos.request'
import appManager from '@ohos.app.ability.appManager'
import App from '@system.app'
import File from '@system.file'
import common from '@ohos.app.ability.common'
import fs from '@ohos.file.fs';


@Concurrent
async function transferAtomics(arg1: CatData, fPath: string, ctx: Context): Promise<String> {
  let downloadTask;
  MyLog.e("wait begin::  " + arg1.url);
  // 使用Atomics进行操作
  // let res = Atomics.wait(arg1, 0, 0, 3000);

  try {
    let back = await request.downloadFile(ctx, { url: arg1.url, header: { 'x-api-key': "live_aK46UpThibgCvmIMnpvB38RYj9XFiDnqJFdypXUG2SnK8AviL3u1X2V22d7MsLZl" }, filePath: fPath })

    let filePath = await back.getTaskInfo()

    return "下载成功 : " + filePath.filePath
  } catch (err) {
    MyLog.e('err.code : ' + err.code + ', err.message : ' + err.message);


    return "下载失败"
  }

}

@Entry
@Component
struct CatBreedListPage {
  private catSource = new CatDataSource()
  @State success: boolean = false
  private scroller = new Scroller()
  private context = getContext(this) as common.UIAbilityContext;
  private filesDir = this.context.filesDir;

  startTask(arg1: CatData) {
    let task: taskpool.Task = new taskpool.Task(transferAtomics, arg1, this.filesDir + "/" + arg1.id + ".jpg", this.context);
    taskpool.execute(task).then((res) => {
      MyLog.e("this res is: " + res);
    })
    setTimeout(() => {
    }, 1000);
  }

  aboutToAppear() {
    this.getList()
  }

  build() {
    List() {
      LazyForEach(this.catSource, (childItem: CatData) => {
        ListItem() {
          CatItemView({ item: childItem })
        }.width('100%')
      })
    }
    .cachedCount(3) // 缓存3个
    .width('100%')
    .height('100%')
  }

  getList() {
    fs.stat(this.filesDir).then(function (stat) {
      console.info("get file info succeed, the size of file is " + stat.size);
    }).catch(function (err) {
      console.info("get file info failed with error message: " + err.message + ", error code: " + err.code);
    });



    let breedid = router.getParams()?.['breedid']

    MyLog.e("this.breedid : " + breedid)

    catVm.searchCatsPromise(breedid).then((response: AxiosResponse) => {
      let result: Array<CatData> = response.data

      this.catSource.setData(result)

      // this.dataSource.pushData(result)
      // if (data.success) {
      //
      // } else {
      //   // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
      // }
      for (let resultElement of result) {
        this.startTask(resultElement)
      }


      this.success = true
    })
      .catch((error: AxiosError) => {
        MyLog.e("result:" + error.message);
        this.success = false
      })
      .then(() => {
        //最终执行
      })
  }
}

