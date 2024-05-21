import { ListInfoModel, wenda } from '../../../../api'
import { RefreshList } from '../../../../component/RefreshList'
import { ListAdapter } from '../../../../utils'
import { QuestionCard } from './QuestionCard'

@Component
export struct QuestionList {
  @Require @Prop state: string = ''
  @State private  adapter: ListAdapter<wenda.WenDaList> = new ListAdapter<wenda.WenDaList>([])
  @State private  wendaDate: ListInfoModel<wenda.WenDaList> | null = null

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  async refresh() {
    this.wendaDate = await wenda.wenda_list(1, this.state)
    this.adapter.setData(this.wendaDate.list)
  }

  async loading() {
    if (this.wendaDate?.hasNext) {
      const tempData: ListInfoModel<wenda.WenDaList> = await wenda.wenda_list(this.wendaDate.currentPage + 1, this.state)
      this.wendaDate.list.push(...tempData.list)
      this.wendaDate.hasNext = tempData.hasNext
      this.wendaDate.currentPage = tempData.currentPage
      this.adapter?.addData(...tempData.list)
    }
  }

  build() {
    if (this.adapter) {
      RefreshList({
        listAdapter: $adapter,
        bgColor: $r('app.color.list_back'),
        hasNext: this.wendaDate?.hasNext,
        bottomDistance: 56,
        leftDistance: 10,
        rightDistance: 10,
        itemView: this.listItem,
        refresh: async () => {
          await this.refresh()
        },
        loading: async () => {
          await this.loading()
        }
      })
    }
  }


  @Builder
  listItem(item: object | string | number | boolean, index: number){
    QuestionCard({
      content: item as wenda.WenDaList
    })
  }
}