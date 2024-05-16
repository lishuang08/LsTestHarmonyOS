import { CatBreedData } from '../dataclass/CatBreedData';
import { ListData } from '../dataclass/ListData';
import { MyLog } from '../util/MyLog';
import { BasicDataSource } from './BasicDataSource';
import ArrayList from '@ohos.util.ArrayList';

/**list数据source
 * */
export class CatBreedSource extends BasicDataSource {
  private list: Array<CatBreedData> = Array<CatBreedData>()

  public totalCount(): number {
    return this.list.length;
  }

  public getData(index: number): CatBreedData {
    return this.list[index];
  }

  public setData(newList: Array<CatBreedData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    MyLog.i("aaaa" + newList)
    this.list = newList
    this.notifyDataReload()
    // }
  }

  public addData(newList: Array<CatBreedData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    MyLog.i("aaaa" + newList)
    this.list = [...this.list, ...newList]
    this.notifyDataReload()
    // }
  }
}
