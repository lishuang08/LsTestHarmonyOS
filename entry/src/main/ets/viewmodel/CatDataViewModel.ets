import { MyLog } from '../util/MyLog';
import { CatData } from '../dataclass/CatData';

import axiosUtils from './../network/AxiosUtils'
import { CatBreedData } from '../dataclass/CatBreedData';
import { ListDataSource } from '../datasource/ListDataSource';
import { AxiosError, AxiosResponse } from '@ohos/axios';

class CatDataViewModel {


  getListDataPromise(currentPage: number = 0, pageSize: number = 20) {
    // 发送get请求
    return axiosUtils.instance.get<string, AxiosResponse<Array<CatBreedData>>, null>("/breeds?limit=" + pageSize + "&page=" + currentPage)
  }
}

let catVm = new CatDataViewModel();

export default catVm as CatDataViewModel;