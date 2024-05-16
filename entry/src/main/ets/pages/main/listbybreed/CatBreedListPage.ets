import catVm from '../../../viewmodel/CatDataViewModel'
import router from '@ohos.router'
import { MyLog } from '../../../util/MyLog'
import { CatData } from '../../../dataclass/CatData'
import { AxiosError, AxiosResponse } from '@ohos/axios';
import { PullToRefresh } from '../../../lib/PullToRefresh/PullToRefresh'
import { CatBreedSource } from '../../../datasource/CatBreedSource'
import { CatDataSource } from '../../../datasource/CatDataSource'
import { CatItem } from './CatItem'

@Entry
@Component
struct CatBreedListPage {
  private catSource = new CatDataSource()
  @State success: boolean = false
  private scroller = new Scroller()

  aboutToAppear() {
    this.getList()
  }

  build() {
    List() {
      LazyForEach(this.catSource, (childItem: CatData) => {
        ListItem() {
          CatItem({ item: childItem })
        }.width('100%')
      })
    }
    .cachedCount(3) // 缓存3个
    .width('100%')
    .height('100%')
  }

  getList() {
    let breedid = router.getParams()?.['breedid']


    MyLog.e("this.breedid : " + breedid)

    catVm.searchCatsPromise( breedid).then((response: AxiosResponse) => {
      let result: Array<CatData> = response.data

      this.catSource.setData(result)
      // this.dataSource.pushData(result)
      // if (data.success) {
      //
      // } else {
      //   // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
      // }
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

