import { ReviewUrls } from '../constants/ReviewUrls';
import ResponseResult from '../common/ResponseResult';
import { httpRequestGet } from '../network/HttpGet';
import Logger from '../util/Logger';
import httpPost from '../network/HttpsPost';
import Network from '@system.network';
import connection from '@ohos.net.connection';
import util from '@ohos.util';
import data_preferences from '@ohos.data.preferences';
import PreferencesUtil from '../util/PreferencesUtil';
import { ListData } from '../dataclass/ListData';
import ArrayList from '@ohos.util.ArrayList';
import { ListDataSource } from './datasource/ListDataSource';
import { ServerDataBack } from '../network/ServerDataBack';
import { CatData } from '../dataclass/CatData';
import { CatDataSource } from './datasource/CatDataSource';

class StartAppViewModel {
  public dataSource = new CatDataSource()
  public list = new Array<CatData>()

  getStartAppData(storage: LocalStorage) {

    // let params = new StartAppParams()

    // Logger.debug("params  %params");

    // "844b5bfd-4024-465e-b35c-298d1c595f4a"

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
      storage.setAndLink("success" , true )
    }).catch(() => {
      storage.setAndLink("success" , false )

      // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
    });
  };
}

let startAppViewModel = new StartAppViewModel();

export default startAppViewModel as StartAppViewModel;
