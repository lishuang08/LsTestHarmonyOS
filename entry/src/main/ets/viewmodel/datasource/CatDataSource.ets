import { ListData } from '../../dataclass/ListData';
import Logger from '../../util/Logger';
import { BasicDataSource } from './BasicDataSource';
import { CatData } from '../../dataclass/CatData';

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

  public pushData(newList: Array<CatData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    // this.listData = [...this.listData, ...goodsInitialList];
    Logger.info("" + newList)
    this.list = newList
    this.notifyDataReload()
    // }
  }
}
