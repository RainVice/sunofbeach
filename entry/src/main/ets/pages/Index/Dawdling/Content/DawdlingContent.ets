import { ListInfo, moyu } from '../../../../api'
import { RefreshList } from '../../../../component/RefreshList'
import { ListAdapter } from '../../../../utils'
import { DawdlingCard } from './DawdilingCard'

@Component
export struct DawdlingContent {
  @Prop topicInfo: moyu.TopicIndex
  @State hasNext: boolean = true
  @State adapter: ListAdapter<moyu.MoyuContent> | null = null
  private moyuData: ListInfo<moyu.MoyuContent> | null = null

  async aboutToAppear() {
    await this.refresh()
  }

  async refresh() {
    this.moyuData = await moyu.listForTopicId(this.topicInfo.id, 1)
    this.hasNext = this.moyuData.hasNext
    if (this.adapter) {
      this.adapter.setData(this.moyuData.list)
    }
    else {
      this.adapter = new ListAdapter<moyu.MoyuContent>(this.moyuData.list)
    }
  }

  async loading() {
    if (this.moyuData?.hasNext) {
      const tempData: ListInfo<moyu.MoyuContent> = await moyu.listForTopicId(this.topicInfo.id, this.moyuData.currentPage + 1)
      this.moyuData.list.push(...tempData.list)
      this.moyuData.hasNext = tempData.hasNext
      this.moyuData.currentPage = tempData.currentPage
      this.hasNext = tempData.hasNext
      this.adapter?.addData(...tempData.list)
    }
  }

  build() {
    if (this.adapter) {
      RefreshList({
        listAdapter: $adapter,
        hasNext: this.hasNext,
        topDistance: 35,
        bottomDistance: 56,
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
  listItem(item: object, index: number) {
    DawdlingCard({ moyuContent: item as moyu.MoyuContent })
  }
}