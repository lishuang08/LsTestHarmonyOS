import http from '@ohos.net.http';
import { ResponseResult } from '../common/ResponseResult';
import { MyLog } from '../util/MyLog';


export default async function httpPost(url: string, requestBody: Object): Promise<Object> {
  if (!url) {
    return Object;
  }

  let httpRequest = http.createHttp();
  let options = {
    method: http.RequestMethod.POST,
    header: {
      'Content-Type': 'application/json'
    },
    extraData: requestBody
  } as http.HttpRequestOptions;

  let responseResult = httpRequest.request(url, options);

  let serverData: ResponseResult = new ResponseResult();
  // 处理数据，并返回
  return responseResult.then((value: http.HttpResponse) => {
    // data.result为HTTP响应内容，可根据业务需要进行解析
    MyLog.e('Result:' + JSON.stringify(value.result));
    MyLog.e('code:' + JSON.stringify(value.responseCode));
    // data.header为HTTP响应头，可根据业务需要进行解析
    MyLog.e('header:' + JSON.stringify(value.header));
    MyLog.e('cookies:' + JSON.stringify(value.cookies)); // 8+

    if (value.responseCode === 200) {
      // 获取返回数据
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);

      serverData.data = resultJson.data;

      serverData.status = resultJson.status;

      serverData.data = resultJson.data;
    } else {
      serverData.errMsg = "null"
    }
    return serverData;
  }).catch(() => {
    serverData.errMsg = ""
    return serverData;
  })
}