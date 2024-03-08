import getAppReviewUrl from '../constants/UrlConstants';


export class ReviewUrls {
  //startApp 接口
  static  getStartAppUrl(): string  {
    return getAppReviewUrl() + "mobile/startapp/execute.json"
  }
}