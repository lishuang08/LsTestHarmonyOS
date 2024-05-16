import http from '@ohos.net.http'
import axios, { AxiosError, AxiosResponse } from '@ohos/axios';
import { MyLog } from '../util/MyLog';
import { ServerDataBack } from './ServerDataBack';



export async function httpRequestGet(url: string): Promise<Object> {
  if (!url) {
    return Object
  }

  let httpRequest = http.createHttp();
  // 发送数据请求
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    header: {
      'Content-Type': 'application/json'
    },
    extraData: {}
  });

  let serverData = new ServerDataBack();
  // 处理数据，并返回
  return responseResult.then((response: http.HttpResponse) => {

    // data.result为http响应内容，可根据业务需要进行解析
    MyLog.e('Result is ' + response.result);
    MyLog.e('code is' + response.responseCode);
    // data.header为http响应头，可根据业务需要进行解析
    MyLog.e('header is' + JSON.stringify(response.header));
    MyLog.e('cookies is' + response.cookies); // 8+


    if (response.responseCode === 200) {
      // 获取返回数据
      serverData.data = response.result
      serverData.code = response.responseCode;
      //
    } else {
      serverData.code = response.responseCode
      serverData.msg = "请求错误"
    }

    return serverData;
  }).catch(() => {
    // serverData.msg = $r('app.string.http_error_message');
    return serverData;
  })
}


