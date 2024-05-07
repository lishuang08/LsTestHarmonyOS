import { ListData } from '../dataclass/ListData';
import { ServerDataBack } from '../network/ServerDataBack';
import { ListDataSource } from '../datasource/ListDataSource';

import singleAxios from '../network/AxiosUtils'
import { AxiosError, AxiosResponse } from '@ohos/axios';
import { CatBreedData } from '../dataclass/CatBreedData';
import { MyLog } from '../util/MyLog';

class MainViewModel {
  public dataSource = new ListDataSource()

  getListData() {
    // 发送get请求
    singleAxios.instance
      .get<string, AxiosResponse<Array<CatBreedData>>, null>("/breeds?limit=20&page=0")
      .then((response: AxiosResponse) => {
        MyLog.e("result:" + JSON.stringify(response.data));

        let result: Array<CatBreedData> = response.data
        // getListSuccess = true
        if (response.status == 200) {
          this.dataSource.pushData(result)
        } else {
          // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
        }
        // Logger.error(getListSuccess + " ")
      })
      .catch((error: AxiosError) => {
        MyLog.e("result:" + error.message);
        // getListSuccess = false
      })
      .then(() => {
        //最终执行

      })

  }
}

let mainViewModel = new MainViewModel();

export default mainViewModel as MainViewModel;