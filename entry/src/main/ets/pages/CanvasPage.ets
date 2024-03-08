@Entry
@Component
struct CanvasPage {
  @State message: string = 'Hello World'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Row() {
      Column() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Green)
          .onReady(() => {
            this.context.font = '30px sans-serif'
            this.context.strokeStyle = '#000000';
            this.context.fillText("Hello World", 20, 60)
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}