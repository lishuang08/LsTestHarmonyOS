import { ListData } from '../../dataclass/ListData';
import Logger from '../../util/Logger';
import { BasicDataSource } from './BasicDataSource';

/**list数据source
 * */
export class ListDataSource extends BasicDataSource {
  private list: Array<ListData> = Array<ListData>(new ListData());

  public totalCount(): number {
    return this.list.length;
  }

  public getData(index: number): ListData {
    return this.list[index];
  }

  public pushData(newList: Array<ListData>): void {
    // if (this.listData.length < MAX_DATA_LENGTH) {
    // this.listData = [...this.listData, ...goodsInitialList];
    Logger.info("" + newList)
    this.list = newList
    this.notifyDataReload()
    // }
  }
}
