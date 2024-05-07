// import { LogConfiguration } from '@ohos-port/xlog';
import { Log } from '../lib/Log/Log'
// import { XLog } from '@ohos-port/xlog/src/main/ets/components/XLog';

export class MyLog {
  static init(){

    Log.init({
      tag: "HarmonyOSLog",
      domain: 0x0000,
      close: false,
      isHilog: true,
      showLogLocation: true,
      logSize: 800
    })
  }


  static i(msg: string) {
    Log.info(msg)
  }

  static e(msg: string) {
    Log.error(msg)
  }

  static w(msg: string) {
    Log.warn(msg)
  }

  static d(msg: string) {
    Log.debug(msg)
  }
}