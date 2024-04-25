import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import util from '@ohos.util';
import { GlobalContext } from '../util/GlobalContext';
import PreferencesUtil from '../util/PreferencesUtil';
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

import {
  DateFileNameGenerator,
  FileLastModifiedCleanStrategy,
  FilePrinter,
  FileSizeBackupStrategy,
  LogConfiguration,
  OhPrinter,
  XLog
} from '@ohos-port/xlog';

export default class EntryAbility extends UIAbility {
  private nums = ["1", 1, "3", false]

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {

    // this.context.eventHub.on('DetailPage', () => {
    //   // 'eventHub' can't support crossplatform application.
    //   Logger.info("from detail url ")
    // })

    this.initLibrary()

    XLog.i('Ability onCreate');

    GlobalContext.getContext().setObject('abilityWant', want);

    PreferencesUtil.createPreferences(this.context);

    PreferencesUtil.getStringData("uuid").then((value) => {
      if (value == "") {
        let uuid = util.generateRandomUUID(true)
        PreferencesUtil.saveStringData(uuid, "uuid");
        XLog.d("new uuid :" + uuid)
      } else {
        XLog.d("old uuid :" + value)
      }
    });

    let l = "aaa"
    l = "222"
    // var v = "bbb" //不再支持 var
    // v = "111"
    XLog.e("l  1: " + l)
    this.nums.forEach(element => {
      if (element) {
        // var v = "ccc"
        let l = "333"
        XLog.e("l  2: " + l)
      }
    })
  }

  async initLibrary() {
    let config = new LogConfiguration.Builder()
      .setTag("lstestapp")
      .build();
    // let printer = new FilePrinter.Builder(`${a}/log`)
    //   .setCleanStrategy(new FileLastModifiedCleanStrategy(24 * 60 * 60 * 1000)) //24h
    //   .setFileNameGenerator(new DateFileNameGenerator())
    //   .setBackupStrategy(new FileSizeBackupStrategy(10 * 1024 * 1024)) // 10MB
    //   .build();
    XLog.init(config);

    axios.defaults.baseURL = 'https://api.thecatapi.com/v1';
    axios.defaults.headers.common['x-api-key'] = "live_aK46UpThibgCvmIMnpvB38RYj9XFiDnqJFdypXUG2SnK8AviL3u1X2V22d7MsLZl";
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
    axios.defaults.timeout = 30 * 1000

    // 添加请求拦截器
    axios.create().interceptors.request.use((config: InternalAxiosRequestConfig) => {
      XLog.d("result config.url: " + config.url);
      // 对请求数据做点什么
      return config;
    }, (error: AxiosError) => {
      // 对请求错误做些什么
      return Promise.reject(error);
    });

    // 添加响应拦截器
    axios.create().interceptors.response.use((response: AxiosResponse) => {

      XLog.d("result response: " + response);

      // 对响应数据做点什么
      return response;
    }, (error: AxiosError) => {
      // 对响应错误做点什么
      return Promise.reject(error);
    });

  }


  onDestroy(): void {
    XLog.i('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    XLog.i('Ability onWindowStageCreate');

    windowStage.loadContent("pages/SplashScreenPage", (err, data) => {
      if (err.code) {
        XLog.i('Failed to load the content. Cause: %{public}s' + JSON.stringify(err) ?? '');
        return;
      }
      XLog.i('Succeeded in loading the content. Data: %{public}s' + JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    XLog.i('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    XLog.i('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    XLog.i('Ability onBackground');
  }
}