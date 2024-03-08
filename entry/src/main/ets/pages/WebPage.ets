import webview from '@ohos.web.webview';

@Entry
@Component
struct WebPage {
  @State message: string = 'Hello World'

  private  controller   = new webview.WebviewController();


  build() {
    Row() {
      Column() {
        Web({ src: "https:www.baidu.com", controller: this.controller })
          .onConfirm((event) => {
            AlertDialog.show({
              title: 'title',
              message: event.message,
              confirm: {
                value: 'onAlert',
                action: () => {
                  event.result.handleConfirm();
                }
              },
              cancel: () => {
                event.result.handleCancel();
              }
            })
            return true;
          }).height('100%')
          .width('100%')
      }
      .width('100%')
    }
    .height('100%')
  }
}