import HashMap from '@ohos.util.HashMap';
// 导入模块
import worker from '@ohos.worker';


export class ImageManager {
  public imageMap: HashMap<string, PixelMap> = new HashMap<string, PixelMap>();
  // API 9及之后版本使用：
  worker1 = new worker.ThreadWorker("../workers/WorkerDownImage/");

  add() {

  }
}

export default new ImageManager();