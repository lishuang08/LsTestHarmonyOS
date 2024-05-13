

export default class RefreshConstants {

  /**
   * The refresh and load height.
   */
  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;

  /**
   * Release title.
   */
  static readonly RELEASE_TITLE: string = '新闻发布';

  /**
   * The off set coefficient.
   */
  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;

  /**
   * The delay time.
   */
  static readonly DELAY_TIME: number = 1000;

  /**
   * The animation delay time.
   */
  static readonly DELAY_ANIMATION_DURATION: number = 300;

  /**
   * 100 percent.
   */
  static readonly FULL_PERCENT: string = '100%';

  /**
   * Divider width.
   */
  static readonly DIVIDER_WIDTH: string = '90%';

}

/**
 * The newsList state enum.
 */
export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}


/**
 * The refresh state enum.
 */
export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}

/**
 * The RefreshConstant constants.
 */
export const enum RefreshConstant {
  DELAY_PULL_DOWN_REFRESH = 50,
  CLOSE_PULL_DOWN_REFRESH_TIME = 150,
  DELAY_SHRINK_ANIMATION_TIME = 500
}