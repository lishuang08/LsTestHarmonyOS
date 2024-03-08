import { ListData } from '../dataclass/ListData';
import { httpRequestGet } from '../network/HttpGet';
import { ServerDataBack } from '../network/ServerDataBack';
import { ListDataSource } from './datasource/ListDataSource';

class  MainViewModel{


  getListData( listDataSource :ListDataSource , getListSuccess: boolean )  {


    let url = "https://jsonplaceholder.typicode.com/posts"
    httpRequestGet(url).then((data: ServerDataBack) => {
      let result: Array<ListData> = JSON.parse(`${data.data}`)
      listDataSource.pushData(result)

      getListSuccess = true
      // if (data.success) {
      //
      // } else {
      //   // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
      // }
    }).catch(() => {
      getListSuccess = false
    });
  };
}

let mainViewModel = new MainViewModel();

export default mainViewModel as MainViewModel;