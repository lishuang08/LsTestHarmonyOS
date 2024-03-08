export class TabItemData {
  constructor(str: string, n: number) {
    this.name = str
    this.page = n
  }

  page: number = 0
  name: string
}