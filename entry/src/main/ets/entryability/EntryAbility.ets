import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import util from '@ohos.util';
import { GlobalContext } from '../util/GlobalContext';
import PreferencesUtil from '../util/PreferencesUtil';
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

// import { MMKV } from '@tencent/mmkv';
import bundleManager from '@ohos.bundle.bundleManager';
import { MyLog } from '../util/MyLog';

export default class EntryAbility extends UIAbility {
  private nums = ["1", 1, "3", false]

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {

    // this.context.eventHub.on('DetailPage', () => {
    //   // 'eventHub' can't support crossplatform application.
    //   Logger.info("from detail url ")
    // })

    this.initLibrary()

    MyLog.i('Ability onCreate');

    GlobalContext.getContext().setObject('abilityWant', want);

    PreferencesUtil.createPreferences(this.context);

    PreferencesUtil.getStringData("uuid").then((value) => {
      if (value == "") {
        let uuid = util.generateRandomUUID(true)
        PreferencesUtil.saveStringData(uuid, "uuid");
        MyLog.d("new uuid :" + uuid)
      } else {
        MyLog.d("old uuid :" + value)
      }
    });

    let l = "aaa"
    l = "222"
    // var v = "bbb" //不再支持 var
    // v = "111"
    MyLog.e("l  1: " + l)
    this.nums.forEach(element => {
      if (element) {
        // var v = "ccc"
        let l = "333"
        MyLog.e("l  2: " + l)
      }
    })
  }

  async initLibrary() {
    //初始化mmkv
    // let appCtx = this.context.getApplicationContext();
    // let mmkvRootDir = MMKV.initialize(appCtx);

    MyLog.init();

    //初始化axios
    axios.defaults.baseURL = 'https://api.thecatapi.com/v1';
    axios.defaults.headers.common['x-api-key'] = "live_aK46UpThibgCvmIMnpvB38RYj9XFiDnqJFdypXUG2SnK8AviL3u1X2V22d7MsLZl";
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
    axios.defaults.timeout = 30 * 1000

    //高德获取appid
    let flag = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
    let bundleInfo = await bundleManager.getBundleInfoForSelf(flag)
    let appId = bundleInfo.signatureInfo.appId;

    MyLog.e("appId : " + appId)
  }
  onDestroy(): void {
    MyLog.i('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    MyLog.i('Ability onWindowStageCreate');

    windowStage.loadContent("pages/SplashScreenPage", (err, data) => {
      if (err.code) {
        MyLog.i('Failed to load the content. Cause: %{public}s' + JSON.stringify(err) ?? '');
        return;
      }
      MyLog.i('Succeeded in loading the content. Data: %{public}s' + JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    MyLog.i('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    MyLog.i('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    MyLog.i('Ability onBackground');
  }
}