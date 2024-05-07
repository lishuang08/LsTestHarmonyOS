import axios, {
  AxiosError,
  AxiosInstance,
  AxiosResponse,
  AxiosStatic,
  InternalAxiosRequestConfig
} from '@ohos/axios'
import { MyLog } from '../util/MyLog';

export class AxiosUtils {
  instance: AxiosInstance

  constructor() {
    this.instance = this.getInstance()
    this.instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
      MyLog.d("request config.url: " + config.url);

      // 对请求数据做点什么
      return config;
    }, (error: AxiosError) => {
      // 对请求错误做些什么

      return Promise.reject(error);
    });

    this.instance.interceptors.response.use((response: AxiosResponse) => {

      MyLog.d("result response: " + response);
      // 对响应数据做点什么
      return response;
    }, (error: AxiosError) => {
      // 对响应错误做点什么
      return Promise.reject(error);
    });
  }

  protected getInstance(): AxiosInstance {
    const ax = axios.create()

    return ax
  }
}

export default new AxiosUtils();