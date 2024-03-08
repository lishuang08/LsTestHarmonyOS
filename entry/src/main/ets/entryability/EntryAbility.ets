import type AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import type Want from '@ohos.app.ability.Want';
import type window from '@ohos.window';
import Logger from '../util/Logger';
import util from '@ohos.util';
import { GlobalContext } from '../util/GlobalContext';
import PreferencesUtil from '../util/PreferencesUtil';




export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Logger.info('%{public}s', 'Ability onCreate');

    GlobalContext.getContext().setObject('abilityWant', want);

    PreferencesUtil.createPreferences(this.context);

    PreferencesUtil.getStringData("uuid").then((value) => {
      if (value  == "") {
        let uuid = util.generateRandomUUID(true)
        PreferencesUtil.saveStringData(uuid, "uuid");
        Logger.debug("new uuid :" + uuid)
      }else {
        Logger.debug("old uuid :" + value)
      }
    });

  }

  onDestroy(): void {
    Logger.info('%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info('%{public}s', 'Ability onWindowStageCreate');


    windowStage.loadContent("pages/SplashScreenPage", (err, data) => {
      if (err.code) {
        Logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Logger.info('Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });


  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info('%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info('%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info('%{public}s', 'Ability onBackground');
  }
}