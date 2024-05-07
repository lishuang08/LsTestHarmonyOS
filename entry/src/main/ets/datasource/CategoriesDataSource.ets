import { CategoriesData } from '../dataclass/CategoriesData';
import { MyLog } from '../util/MyLog';
import { BasicDataSource } from './BasicDataSource';

/**list数据source
 * */
export class CategoriesDataSource extends BasicDataSource {
  private list: Array<CategoriesData> = Array<CategoriesData>();

  public totalCount(): number {
    return this.list.length;
  }

  public getData(index: number): CategoriesData {
    return this.list[index];
  }

  public pushData(newList: Array<CategoriesData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    // this.listData = [...this.listData, ...goodsInitialList];
    MyLog.i("aaaa" + newList)
    this.list = newList
    this.notifyDataReload()
    // }
  }
}
