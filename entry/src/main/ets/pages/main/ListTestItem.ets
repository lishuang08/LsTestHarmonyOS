
@Preview
@Component
export struct ListTestItem {
  @State items: Array<String> = Array<String>('111', '2', '3')

  aboutToAppear() {
  }

  build() {
    List() {
      ForEach(this.items, (item: string) => {
        ListItem() {
          Column() {
            Text(item) {

            }.width('100%').fontSize(20)

            Text(item.length + "") {
            }.width('100%').fontSize(16)
          }
        }
      })
    }.width('100%')
    .cachedCount(3) // 扩大数值appear日志范围会变大

  }
}


