export class ResponseResult {
  //共有数据
  status: String //状态 0为成功 ，-1 token失效，
  errCode: String
  errMsg: String
  data: Object //有可能没有 为null，部分接口无字段

  constructor(status: string, errCode: String, errMsg: String, data: Object) {
    this.status = status;
    this.errCode = errCode;
    this.errMsg = errMsg;
    this.data = data
  }
}