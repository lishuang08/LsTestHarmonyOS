import { ReviewUrls } from '../constants/ReviewUrls';
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

  };
}

let startAppViewModel = new StartAppViewModel();

export default startAppViewModel as StartAppViewModel;
