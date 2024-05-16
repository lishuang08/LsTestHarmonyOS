import RefreshConstants, { PageState } from '../../constants/RefreshConstants';
import { CatBreedData } from '../../dataclass/CatBreedData';
import { showToast } from '../../util/ToastUtil';
import FailureLayout from '../../view/FailureLayout';
import LoadingLayout from '../../view/LoadingLayout';
import LoadMoreLayout from '../../view/LoadMoreLayout';
import NoMoreLayout from '../../view/NoMoreLayout';
import RefreshLayout from '../../view/RefreshLayout';
import CatDataViewModel from '../../viewmodel/CatDataViewModel';
import RefreshListViewModel from '../../viewmodel/RefreshListViewModel';
import { MainChildItem } from './MainChildItem';
import { AxiosError, AxiosResponse } from '@ohos/axios';
import { MyLog } from '../../util/MyLog';
import ArrayList from '@ohos.util.ArrayList';

@Component
export struct MainRefreshView {
  index: number = 1; //当前页的标签 1
  @Watch('changeCategory') @Link currentIndex: number; // 关联父类的tab，当前页的标签
  @State getSuccess: boolean = false
  @State refreshStore: RefreshListViewModel = new RefreshListViewModel();

  changeCategory() {
    if (this.currentIndex !== this.index) {
      return;
    }

    this.refreshStore.currentPage = 0;
    CatDataViewModel.getListDataPromise(this.refreshStore.currentPage, this.refreshStore.pageSize).then((response: AxiosResponse) => {
      MyLog.i("result:" + JSON.stringify(response.data));
      let result: Array<CatBreedData> = response.data
      if (response.status == 200) {
        this.refreshStore.pageState = PageState.Success;

        if (result.length === this.refreshStore.pageSize) {
          this.refreshStore.currentPage++;
          this.refreshStore.hasMore = true;
        } else {
          this.refreshStore.hasMore = false;
        }
        this.refreshStore.listDataSource.setData(result)

      } else {
        // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
      }
      this.getSuccess = true
    }).catch((error: AxiosError) => {
      showToast(error.message);
      this.getSuccess = false
      this.refreshStore.pageState = PageState.Fail;
    }).then(() => {
      //最终执行
    })
  }

  aboutToAppear() {
    this.changeCategory()
  }

  reloadAction() {
    this.refreshStore.pageState = PageState.Loading;
    this.changeCategory();
  }

  build() {
    this.mainRefreshListView()
  }

  @Builder
  mainRefreshListView() {
    Column() {
      if (this.refreshStore.pageState === PageState.Loading) {
        LoadingLayout()
      } else if (this.refreshStore.pageState === PageState.Success) {
        this.listLayout()
      } else {
        FailureLayout({ reloadAction: () => {
          this.reloadAction();
        } })
      }
    }
    .width(RefreshConstants.FULL_PERCENT)
    .height(RefreshConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .onTouch((event?: TouchEvent) => {
      if (event) {
        if (this.refreshStore.pageState === PageState.Success) {
          this.refreshStore.listTouchEvent(event);
        }
      }
    })

  }

  @Builder
  listLayout() {
    List() {
      ListItem() {
        RefreshLayout({ refreshLoadingClass: this.refreshStore.refreshLayoutClass })
      }
      LazyForEach(this.refreshStore.listDataSource, (childItem: CatBreedData) => {
        ListItem() {
          MainChildItem({ item: childItem })
        }.width('100%')
      })
      ListItem() {
        if (this.refreshStore.hasMore) {
          LoadMoreLayout({ loadMoreLayoutClass: this.refreshStore.loadingMoreClass })
        } else {
          NoMoreLayout()
        }
      }
    }
    .cachedCount(3) // 缓存3个
    .width('100%')
    .height('100%')
    .edgeEffect(EdgeEffect.None)
    .onScrollIndex((start: number, end: number) => {
      this.refreshStore.startIndex = start;
      this.refreshStore.endIndex = end;
    })
    // .onScrollFrameBegin((offset, state) => {
    //   //设置为0 ,禁止滑动
    //   return { offsetRemain: 0 }
    // })
  }
}