import { content, ListInfoModel } from '../../../../api'
import { RefreshList } from '../../../../component'
import { ListAdapter } from '../../../../utils'
import { ArticleCard } from './ArticleCard'

@Component
export struct ArticleList {

  @Require @Prop categoryInfo: content.Category
  @State contentInfo : ListInfoModel<content.CtContent> | null = null
  @State adapter: ListAdapter<content.CtContent>  = new ListAdapter()

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  async refresh(){
    this.contentInfo = await content.content(this.categoryInfo.id,1)
    this.adapter.setData(this.contentInfo.list)
  }

  async loading(){
    if (this.contentInfo?.hasNext) {
      const temp = await content.content(this.categoryInfo.id,this.contentInfo.currentPage + 1)
      this.contentInfo.list.push(...temp.list)
      this.contentInfo.hasNext = temp.hasNext
      this.contentInfo.currentPage = temp.currentPage
      this.adapter.addData(...temp.list)
    }
  }

  build() {
    if (this.adapter){
      RefreshList({
        space: 15,
        listAdapter: this.adapter,
        bgColor: $r('app.color.list_back'),
        hasNext: this.contentInfo?.hasNext,
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
  listItem(item: object | string | number | boolean, index: number) {
    ArticleCard({ ctContent: item as content.CtContent })
  }
}