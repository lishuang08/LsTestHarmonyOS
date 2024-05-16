import { MyLog } from '../util/MyLog';
import { CatData } from '../dataclass/CatData';

import axiosUtils from './../network/AxiosUtils'
import { CatBreedData } from '../dataclass/CatBreedData';
import { CatBreedSource } from '../datasource/CatBreedSource';
import { AxiosError, AxiosResponse } from '@ohos/axios';

class CatDataViewModel {


  getListDataPromise(currentPage: number = 0, pageSize: number = 20) {
    // 发送get请求
    return axiosUtils.instance.get<string, AxiosResponse<Array<CatBreedData>>, null>("/breeds?limit=" + pageSize + "&page=" + currentPage)
  }

  searchCatsPromise(breedis: string  = "",currentPage: number = 0, pageSize: number = 20 ) {
    // 发送get请求
    return axiosUtils.instance.get<string, AxiosResponse<Array<CatBreedData>>, null>("/images/search?limit=" + pageSize + "&page=" + currentPage + "&breed_ids=" +breedis)
  }


}

let catVm = new CatDataViewModel();

export default catVm as CatDataViewModel;