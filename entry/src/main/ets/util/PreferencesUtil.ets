/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import dataPreferences from '@ohos.data.preferences';
import { GlobalContext } from './GlobalContext';
import Logger from './Logger';

const PREFERENCES_NAME = 'myPreferences';
const KEY_APP_FONT_SIZE = 'appFontSize';
const SAVE_PREFERENCES_NAME = "getXcyPreferences"


/**
 * The PreferencesUtil provides preferences of create, save and query.
 */
export class PreferencesUtil {
  createPreferences(context: Context) {
    let fontPreferences: Function = (() => {
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context,
        PREFERENCES_NAME);
      return preferences;
    });
    GlobalContext.getContext().setObject(SAVE_PREFERENCES_NAME, fontPreferences);
  }

  // saveStringData(fontSize: string ) {
  //   let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
  //   getFontPreferences().then((preferences: dataPreferences.Preferences) => {
  //     preferences.has(KEY_APP_FONT_SIZE).then(async (isExist: boolean) => {
  //       Logger.info(TAG, 'preferences has changeFontSize is ' + isExist);
  //       if (!isExist) {
  //         await preferences.put(KEY_APP_FONT_SIZE, fontSize);
  //         preferences.flush();
  //       }
  //     }).catch((err: Error) => {
  //       Logger.error(TAG, 'Has the value failed with err: ' + err);
  //     });
  //   }).catch((err: Error) => {
  //     Logger.error(TAG, 'Get the preferences failed, err: ' + err);
  //   });
  // }

  saveStringData(str: string, key: string) {
    let getFontPreferences: Function = GlobalContext.getContext().getObject(SAVE_PREFERENCES_NAME) as Function;
    getFontPreferences().then(async (preferences: dataPreferences.Preferences) => {
      await preferences.put(key, str);
      preferences.flush();
    }).catch((err: Error) => {
      Logger.error('put the preferences failed, err: ' + err);
    });
  }

  async getStringData(key: string) {
    let str: string = "";
    let getFontPreferences: Function = GlobalContext.getContext().getObject(SAVE_PREFERENCES_NAME) as Function;
    str = await (await getFontPreferences()).get(key, "");
    return str;
  }


  async getChangeFontSize() {
    let fontSize: number = 0;
    let getFontPreferences: Function = GlobalContext.getContext().getObject(SAVE_PREFERENCES_NAME) as Function;
    fontSize = await (await getFontPreferences()).get(KEY_APP_FONT_SIZE, fontSize);
    return fontSize;
  }

  async deleteChangeFontSize() {
    let getFontPreferences: Function = GlobalContext.getContext().getObject(SAVE_PREFERENCES_NAME) as Function;
    const preferences: dataPreferences.Preferences = await getFontPreferences();
    let deleteValue = preferences.delete(KEY_APP_FONT_SIZE);
    deleteValue.then(() => {
      Logger.info('Succeeded in deleting the key appFontSize.');
    }).catch((err: Error) => {
      Logger.error('Failed to delete the key appFontSize. Cause: ' + err);
    });
  }
}

export default new PreferencesUtil();