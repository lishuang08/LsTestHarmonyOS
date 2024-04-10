@Entry
@Component
struct Page0 {
  @State message: string = 'Hello World'

  aboutToAppear(){

  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}