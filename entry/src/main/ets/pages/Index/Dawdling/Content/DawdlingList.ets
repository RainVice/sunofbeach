import { ListInfoModel, moyu } from '../../../../api'
import { RefreshList } from '../../../../component'
import { ListAdapter } from '../../../../utils'
import { DawdlingCard } from './DawdilingCard'

@Component
export struct DawdlingList {
  @Prop topicInfo: moyu.TopicIndex
  // @State hasNext: boolean = true
  @State adapter: ListAdapter<moyu.Moment> = new ListAdapter<moyu.Moment>([])
  @State moyuData: ListInfoModel<moyu.Moment> | null = null

  async aboutToAppear() {
    await this.refresh()
  }

  async refresh() {
    this.moyuData = await moyu.momentForTopicId(this.topicInfo.id, 1)
    // this.hasNext = this.moyuData.hasNext
    this.adapter.setData(this.moyuData.list)

  }

  async loading() {
    if (this.moyuData?.hasNext) {
      const tempData: ListInfoModel<moyu.Moment> = await moyu.momentForTopicId(this.topicInfo.id, this.moyuData.currentPage + 1)
      this.moyuData.list.push(...tempData.list)
      this.moyuData.hasNext = tempData.hasNext
      this.moyuData.currentPage = tempData.currentPage
      // this.hasNext = tempData.hasNext
      this.adapter?.addData(...tempData.list)
    }
  }

  build() {
    if (this.adapter) {
      RefreshList({
        listAdapter: $adapter,
        bgColor: $r('app.color.list_back'),
        hasNext: this.moyuData?.hasNext,
        topDistance: 35,
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
  listItem(item: object | string | number | boolean, _index: number) {
    DawdlingCard({ moment: item as moyu.Moment })
  }
}