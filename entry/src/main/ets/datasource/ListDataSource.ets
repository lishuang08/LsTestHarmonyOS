import { CatBreedData } from '../dataclass/CatBreedData';
import { ListData } from '../dataclass/ListData';
import { MyLog } from '../util/MyLog';
import { BasicDataSource } from './BasicDataSource';

/**list数据source
 * */
export class ListDataSource extends BasicDataSource {
  private list: Array<CatBreedData> = Array<CatBreedData>();

  public totalCount(): number {
    return this.list.length;
  }

  public getData(index: number): CatBreedData {
    return this.list[index];
  }

  public pushData(newList: Array<CatBreedData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    // this.listData = [...this.listData, ...goodsInitialList];
    MyLog.i("aaaa" + newList)
    this.list = newList
    this.notifyDataReload()
    // }
  }
}
