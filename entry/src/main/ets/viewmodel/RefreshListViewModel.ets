/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import prompt from '@ohos.promptAction';
import catVm from './CatDataViewModel';
import RefreshConstants, { PageState, RefreshConstant, RefreshState } from '../constants/RefreshConstants';
import { CatData } from '../dataclass/CatData';
import RefreshLoadingClass from './RefreshLoadingClass';
import { MyLog } from '../util/MyLog';
import { CatBreedData } from '../dataclass/CatBreedData';
import { CatBreedSource } from '../datasource/CatBreedSource';

import { AxiosError, AxiosResponse } from '@ohos/axios';

@Observed
export default class RefreshListViewModel {
  private downY = 0;
  private lastMoveY = 0;
  private isRefreshing: boolean = false;
  private isCanRefresh = false;
  private isPullRefreshOperation = false;
  private isLoading: boolean = false;
  private isCanLoadMore = false;
  public startIndex = 0;
  public endIndex = 0;
  public currentPage: number = 0;
  public pageSize: number = 20;
  public offsetY: number = 0;
  public hasMore: boolean = true;
  public refreshLayoutClass: RefreshLoadingClass = new RefreshLoadingClass($r('app.media.ic_pull_down_refresh'), $r('app.string.pull_down_refresh_text'), 0);
  public loadingMoreClass: RefreshLoadingClass = new RefreshLoadingClass($r('app.media.ic_pull_up_load'), $r('app.string.pull_up_load_text'), 0);
  public pageState: number = PageState.Loading;
  public listDataSource = new CatBreedSource()
  public getSuccess: boolean = false

  listTouchEvent(event: TouchEvent) {
    switch (event.type) {
      case TouchType.Down:
        this.downY = event.touches[0].y;
        this.lastMoveY = event.touches[0].y;
        break;
      case TouchType.Move:
        if (this.isRefreshing || this.isLoading) {
          return;
        }
        let isDownPull = event.touches[0].y - this.lastMoveY > 0;
        if ((isDownPull || this.isPullRefreshOperation) && !this.isCanLoadMore) {
          // Touch move pull refresh.
          this.touchMovePullRefresh(event);
        } else {
          // Touch move load more.
          this.touchMoveLoadMore(event);
        }
        this.lastMoveY = event.touches[0].y;
        break;
      case TouchType.Cancel:
        break;
      case TouchType.Up:
        if (this.isRefreshing || this.isLoading) {
          return;
        }
        if (this.isPullRefreshOperation) {
          // Touch up pull refresh.
          this.touchUpPullRefresh();
        } else {
          // Touch up load more.
          this.touchUpLoadMore();
        }
        break;
      default:
        break;
    }
  }

  touchMovePullRefresh(event: TouchEvent) {
    if (this.startIndex === 0) {

      this.isPullRefreshOperation = true;
      let height = vp2px(RefreshConstants.CUSTOM_LAYOUT_HEIGHT);
      this.offsetY = event.touches[0].y - this.downY;
      // Check offsetY to Refresh.
      if (this.offsetY >= height) {
        this.pullRefreshState(RefreshState.Release);
        this.offsetY = height + this.offsetY * RefreshConstants.Y_OFF_SET_COEFFICIENT;
      } else {
        this.pullRefreshState(RefreshState.DropDown);
      }
      if (this.offsetY < 0) {
        this.offsetY = 0;
        this.isPullRefreshOperation = false;
      }
    }
  }

  touchUpPullRefresh() {
    if (this.isCanRefresh) {
      this.offsetY = vp2px(RefreshConstants.CUSTOM_LAYOUT_HEIGHT);
      this.pullRefreshState(RefreshState.Refreshing);
      this.currentPage = 0;
      setTimeout(() => {
        catVm.getListDataPromise(this.currentPage, this.pageSize).then((response: AxiosResponse) => {
          MyLog.i("result:" + JSON.stringify(response.data));
          let result: Array<CatBreedData> = response.data
          if (response.status == 200) {
            if (result.length === this.pageSize) {
              this.currentPage++;
              this.hasMore = true;
            } else {
              this.hasMore = false;
            }
            this.listDataSource.setData(result)
          } else {
            // resolve(Const.TabBars_DEFAULT_NEWS_TYPES);
          }
          this.getSuccess = true
          this.closeRefresh(true);
        }).catch((error: AxiosError) => {
          prompt.showToast({ message: error.message });
          this.closeRefresh(false);
          this.getSuccess = false
        }).then(() => {
          //最终执行
        })
      }, RefreshConstants.DELAY_TIME);
    } else {
      this.closeRefresh(false);
    }
  }

  pullRefreshState(state: number) {
    switch (state) {
      case RefreshState.DropDown:
        this.isCanRefresh = false;
        this.isRefreshing = false;
        this.refreshLayoutClass = new RefreshLoadingClass($r('app.media.ic_pull_down_refresh'),
          $r('app.string.pull_down_refresh_text'), RefreshConstants.CUSTOM_LAYOUT_HEIGHT)
        break;
      case RefreshState.Release:
        this.refreshLayoutClass.imageSrc = $r('app.media.ic_pull_up_refresh');
        this.refreshLayoutClass.textValue = $r('app.string.release_refresh_text');
        this.isCanRefresh = true;
        this.isRefreshing = false;
        break;
      case RefreshState.Refreshing:
        this.offsetY = vp2px(this.refreshLayoutClass.heightValue);
        this.refreshLayoutClass.imageSrc = $r('app.media.ic_pull_up_load');
        this.refreshLayoutClass.textValue = $r('app.string.refreshing_text');
        this.isCanRefresh = true;
        this.isRefreshing = true;
        break;
      case RefreshState.Success:
        this.refreshLayoutClass.imageSrc = $r('app.media.ic_succeed_refresh');
        this.refreshLayoutClass.textValue = $r('app.string.refresh_success_text');
        this.isCanRefresh = true;
        this.isRefreshing = true;
        break;
      case RefreshState.Fail:
        this.refreshLayoutClass.imageSrc = $r('app.media.ic_fail_refresh');
        this.refreshLayoutClass.textValue = $r('app.string.refresh_fail_text');
        this.isCanRefresh = true;
        this.isRefreshing = true;
        break;
      default:
        break;
    }
  }

  closeRefresh(isRefreshSuccess: boolean) {
    setTimeout(() => {

      let delay = RefreshConstant.DELAY_PULL_DOWN_REFRESH;
      if (this.isCanRefresh) {
        this.pullRefreshState(isRefreshSuccess ? RefreshState.Success : RefreshState.Fail);
        delay = RefreshConstant.DELAY_SHRINK_ANIMATION_TIME;
      }
      animateTo({
        duration: RefreshConstant.CLOSE_PULL_DOWN_REFRESH_TIME,
        delay: delay,
        onFinish: () => {
          this.pullRefreshState(RefreshState.DropDown);
          this.refreshLayoutClass.heightValue = 0;
          this.isPullRefreshOperation = false;
        }
      }, () => {
        this.offsetY = 0;
      });
    }, this.isCanRefresh ? RefreshConstants.DELAY_ANIMATION_DURATION : 0);
  }

  touchMoveLoadMore(event: TouchEvent) {
    if (this.endIndex >= this.listDataSource.totalCount() - 1) {
      this.offsetY = event.touches[0].y - this.downY;
      if (Math.abs(this.offsetY) > vp2px(RefreshConstants.CUSTOM_LAYOUT_HEIGHT) / 2) {
        this.isCanLoadMore = true;
        this.loadingMoreClass.heightValue = RefreshConstants.CUSTOM_LAYOUT_HEIGHT;
        this.offsetY = -vp2px(RefreshConstants.CUSTOM_LAYOUT_HEIGHT) + this.offsetY * RefreshConstants.Y_OFF_SET_COEFFICIENT;
      }
    }
  }

  touchUpLoadMore() {
    if (this.isCanLoadMore && this.hasMore) {
      this.isLoading = true;
      setTimeout(() => {
        catVm.getListDataPromise(this.currentPage, this.pageSize).then((response: AxiosResponse) => {
          MyLog.i("result:" + JSON.stringify(response.data));
          let result: Array<CatBreedData> = response.data
          if (response.status == 200) {
            if (result.length === this.pageSize) {
              this.currentPage++;
              this.hasMore = true;
            } else {
              this.hasMore = false;
            }
            this.listDataSource.addData(result)
          } else {

          }
          this.getSuccess = true
        }).catch((error: AxiosError) => {
          prompt.showToast({ message: error.message });
          this.getSuccess = false
        }).then(() => {
          //最终执行
        })
        this.closeLoadMore();
      }, RefreshConstants.DELAY_TIME);
    } else {
      this.closeLoadMore();
    }
  }

  closeLoadMore() {
    this.isCanLoadMore = false;
    this.isLoading = false;
    this.loadingMoreClass.heightValue = 0;
  }
}