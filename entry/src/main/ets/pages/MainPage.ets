import common from '@ohos.app.ability.common';
import router from '@ohos.router';
import Want from '@ohos.app.ability.Want';
import { MainChildPage } from './main/MainChildPage';
import { XLog } from '@ohos-port/xlog/src/main/ets/components/XLog';

@Entry
@Component
struct MainPage {
  // @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  build() {
    Navigation( ) {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          MainChildPage()
        }.tabBar('首页')

        TabContent() {
          Text('推荐的内容').fontSize(30).onClick(() => {
            this.explicitStartAbility()
          })
        }.tabBar('推荐')

        TabContent() {
          Text('跳转其他module的page').fontSize(30).onClick(() => {
            router.pushUrl({
              url: "@bundle:ls.yylx.testos/list_feature/ets/pages/Page0",
            })
          })
        }.tabBar('发现')

        TabContent() {
          Text('退出应用').fontSize(30).onClick(() => {
            // let appCtx = getContext(this) as common.UIAbilityContext;
            // appCtx.isTerminating()
          })
        }.tabBar("我的")
      }
    }
    .title("主标题")
    .mode(NavigationMode.Auto)
    .menus([
      { value: "", icon: '/../resources/base/media/ic_main.svg', action: () => {
      } },
      { value: "", icon: '/../resources/base/media/ic_main.svg', action: () => {
      } }
    ])
    .width('100%')
    .height('100%')

  }

  async explicitStartAbility() {
    try {
      let want: Want = {
        deviceId: "",
        bundleName: "ls.yylx.testos",
        abilityName: "List_featureAbility",
        moduleName: "list_feature",
        'parameters': {
          src: "textMessage",
          count: 45
        }
      }

      let context = getContext(this) as common.UIAbilityContext;
      await context.startAbility(want);
      XLog.i(`explicit start ability succeed`);
    } catch (error) {
      XLog.i(`explicit start ability failed with ${error.code}`);
    }
  }
}