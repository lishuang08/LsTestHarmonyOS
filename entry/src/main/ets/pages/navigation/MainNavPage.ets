import image from '@ohos.multimedia.image';

@Entry
@Component
struct MainNavPage {
  @State message: string = 'Hello World';

  build() {
    Navigation() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .title("主标题")
    .mode(NavigationMode.Split)
    .menus([
      { value: "", icon: '/../resources/base/media/ic_main.svg', action: () => {
      } },
      { value: "", icon: '/../resources/base/media/ic_main.svg', action: () => {
      } }
    ])
    .width('100%')
    .height('100%')
  }
}