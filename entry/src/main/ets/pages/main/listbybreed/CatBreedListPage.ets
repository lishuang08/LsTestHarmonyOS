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
import fileUri from '@ohos.file.fileuri'
import systemDateTime from '@ohos.systemDateTime'
import emitter from '@ohos.events.emitter'
import { EmitterEventData } from '../../../dataclass/EmitterEventData'
import worker, { Event } from '@ohos.worker'


@Concurrent
async function transferAtomics(arg1: CatData, fPath: string, ctx: Context): Promise<String> {
  let downloadTask;
  // MyLog.e("wait begin::  " + arg1.url);
  // 使用Atomics进行操作
  // let res = Atomics.wait(arg1, 0, 0, 3000);

  try {
    let back = await request.downloadFile(ctx, { url: arg1.url, header: { 'x-api-key': "live_aK46UpThibgCvmIMnpvB38RYj9XFiDnqJFdypXUG2SnK8AviL3u1X2V22d7MsLZl" }, filePath: fPath })

    let fileInfo = await back.getTaskInfo()


    return fileInfo.filePath
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
  private cacheDir  = this.context.cacheDir;

  startTask(item: CatData, fPath: string, index: number) {
    // https://cdn2.thecatapi.com/images/uvt2Psd9O.jpg

    let task: taskpool.Task = new taskpool.Task(transferAtomics, item, fPath, this.context);
    taskpool.execute(task).then((res) => {
      let resPath = res as string

      let uri = fileUri.getUriFromPath(fPath); // file://<packageName>/data/storage/el2/base/haps/entry/files/test
      // let fileUriObject = new fileUri.FileUri(uri);

      this.catSource.updateItem(uri, index)
      // MyLog.e("this res is: " + uri);
    })

    // setTimeout(() => {
    // }, 1000);
  }

  aboutToAppear() {
    this.getList()

    this.createWorker()
  }

  async createWorker() {
    let num = await systemDateTime.getCurrentTime(true)

    const worker1: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/WorkerDownImage.ets')


    emitter.on({ eventId: 1 }, (data: emitter.EventData) => {
      let back = data.data as EmitterEventData

      MyLog.e("back :" + back.name + " " + back.id)

    })

    worker1.onerror = () => {
      MyLog.e("worker1.onerror ")
    }

    worker1.dispatchEvent({
      type: "type1",
      timeStamp: num
    })

    worker1.addEventListener("type1", (event: Event) => {
      MyLog.e("event : " + event.type + "   timeStamp : " + event.timeStamp)

    })
    worker1.postMessage("message  111")


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
    fs.stat(this.cacheDir).then(function (stat) {
      MyLog.e("get file info succeed, the size of file is " + stat.size);
    }).catch(function (err) {
      MyLog.e ("get file info failed with error message: " + err.message + ", error code: " + err.code);
    });


    let breedid = router.getParams()?.['breedid']

    // MyLog.e("this.breedid : " + breedid)

    catVm.searchCatsPromise(breedid).then((response: AxiosResponse) => {
      let result: Array<CatData> = response.data

      for (let i = 0; i < result.length; i++) {
        let item = result[i]
        let fPath = this.cacheDir + "/" + item.id + ".jpg"
        try {
          let res = fs.accessSync(fPath)

          if (res) {
            let uri = fileUri.getUriFromPath(fPath); // file://<packageName>/data/storage/el2/base/haps/entry/files/test
            // MyLog.e("file exists  : " + uri);
            item.fileUri = uri
          } else {
            // MyLog.e("file not exists");
            this.startTask(item, fPath, i)
          }
        } catch (error) {
          // @ts-ignore
          let err: BusinessError = error as BusinessError;
          MyLog.e("accessSync failed with error message: " + err.message + ", error code: " + err.code);
        }


      }

      this.catSource.setData(result)

      this.success = true
    })
      .catch((error: AxiosError) => {
        // MyLog.e("result:" + error.message);
        this.success = false
      })
      .then(() => {
        //最终执行
      })
  }
}

