import router from '@ohos.router';
import { CommonConstants } from '../constants/CommonConstants';
import { DataItem } from '../viewmodel/DataItem';
import { ListItemComponent } from './ListItemComponent';
import PageViewModel from '../viewmodel/PageViewModel';

/**
 * List area of the main tab content.
 */
@Component
export struct ListAreaComponent {
  private source = PageViewModel.getListDataSource()

  build() {
    Column() {
      List() {

        LazyForEach(this.source, (item: DataItem) => {
          ListItem() {
            ListItemComponent({ itemInfo: item })
          }
          .onClick(() => {
            router.pushUrl({
              url: CommonConstants.PAGE_NAME,
              params: {
                data: item.title
              }
            });
          })
        }, (item: DataItem, index?: number) => index + JSON.stringify(item))
      }
      .width(CommonConstants.LIST_WIDTH_PERCENT)
      .divider({
        strokeWidth: $r('app.float.divider_height'),
        color: $r('app.color.list_divider'),
        startMargin: $r('app.float.list_divider_start_margin'),
        endMargin: $r('app.float.list_divider_end_margin')
      })
    }
    .width(CommonConstants.COLUMN_WIDTH_PERCENT)
  }
}