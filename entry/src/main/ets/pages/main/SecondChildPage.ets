import { AxiosError, AxiosResponse } from '@ohos/axios';
import { CatData } from '../../dataclass/CatData';
import { CategoriesData } from '../../dataclass/CategoriesData';
import { TabItemData } from '../../dataclass/TabItemData';
import { CategoriesDataSource } from '../../datasource/CategoriesDataSource';
import axiosUtils from '../../network/AxiosUtils'
import { MyLog } from '../../util/MyLog';


@Component
export struct SecondChildPage {
  @State getSuccess: boolean = false
  public dataSource = new CategoriesDataSource()

  aboutToAppear() {
    this.getCategories()
  }

  build() {
    Row() {
      if (this.getSuccess) {
        List() {
          LazyForEach(this.dataSource, (childItem: CategoriesData) => {
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


    }.width('100%')
    .height('100%')
  }

  @Builder
  childItemView(childItem: CategoriesData) {
    Column() {
      Row() {
        Text("ID: " + childItem.id  )
        Text( childItem.name)
      }
    }.width('100%')

  }

  getCategories() {
    axiosUtils.instance
      .get<string, AxiosResponse<Array<CatData>>, null>("/categories")
      .then((response: AxiosResponse) => {
        MyLog.i("result:" + response.data);
        let result: Array<CatData> = response.data

        MyLog.d(result.toString())
        // this.dataSource .pushData()

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