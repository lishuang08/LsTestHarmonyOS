import worker, { Event } from '@ohos.worker'
import systemDateTime from '@ohos.systemDateTime'
import { MyLog } from '../util/MyLog'
import emitter from '@ohos.events.emitter'
import { EmitterEventData } from '../dataclass/EmitterEventData'


@Entry
@Component
struct TestCodePage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      List() {
        ListItem() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
        }

        ListItem() {

          // Pass the this.label reference to the overBuilder component when the overBuilder component is called in the Parent component.
          overBuilder({ paramA1: this.message })
        }

        ListItem() {
          Button('Click me').onClick(() => {
            // After Click me is clicked, the UI text changes from Hello to ArkUI.
            // this.message = 'ArkUI';

            this.createWorker()
          })
        }
      }
      .width('100%')
    }
    .height('100%')
  }

  async createWorker() {
    let num = await systemDateTime.getCurrentTime(true)

    const worker1: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/WorkerDownImage.ets')


    emitter.on({ eventId: 1 }, (data: emitter.EventData) => {
      let back = data.data as EmitterEventData

      this. message = "back :" + back.name + " " + back.id

    })

    worker1.onerror = () => {
      MyLog.e("worker1.onerror ")
    }

    worker1.dispatchEvent({
      type: "type1",
      timeStamp: num
    })
    worker1.postMessage("message  111")

    worker1.addEventListener("type1", (event: Event) => {
      MyLog.e("event : " + event.type + "   timeStamp : " + event.timeStamp)

    })


  }
}

@Builder
function overBuilder(params: Tmp) {
  Row() {
    Text(`UseStateVarByReference: ${params.paramA1} `)
  }
}

class Tmp {
  paramA1: string = ''
}




