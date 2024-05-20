import { BasicDataSource } from './BasicDataSource';
import { CatData } from '../dataclass/CatData';
import { MyLog } from '../util/MyLog';

/**list数据source
 * */
export class CatDataSource extends BasicDataSource {
  private list = Array<CatData>();

  public totalCount(): number {
    return this.list.length;
  }

  public getData(index: number): CatData {
    return this.list[index];
  }

  public setData(newList: Array<CatData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    MyLog.i("aaaa" + newList)
    this.list = newList
    this.notifyDataReload()
    // }
  }

  public addData(newList: Array<CatData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    MyLog.i("aaaa" + newList)
    this.list = [...this.list, ...newList]
    this.notifyDataReload()
    // }
  }

  public updateItem(fPath : string , index: number) {
    this.list[index].fileUri = fPath
    // this.list.splice(index, 1, newItem)
    this.notifyDataChange(index)
  }
}
