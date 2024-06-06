import { ListInfoModel, user } from '../../../../api'
import { Follow } from '../../../../api/user'
import { NavDestinationHeader, RefreshList } from '../../../../component'
import { ListAdapter } from '../../../../utils'

@Component
export struct FollowList {
  @State private adapter: ListAdapter<Follow> = new ListAdapter()
  @StorageProp("userInfo") userInfo: user.UserInfo | null = null
  @State private follows: ListInfoModel<Follow> | null = null

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  async refresh() {
    this.follows = await user.follow_list(this.userInfo!.userId, 1)
    this.adapter.setData(this.follows.list)
  }

  async loading(){
    if (this.follows && this.follows.hasNext && this.userInfo) {
      this.follows = await user.follow_list(this.userInfo.userId, this.follows.currentPage + 1)
      this.adapter.addData(...this.follows.list)
    }
  }

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        NavDestinationHeader() {
          Text("关注列表")
        }
        if (this.follows){
          RefreshList({
            listAdapter: $adapter,
            hasNext: this.follows.hasNext,
            nestedScrollOptions: {
              scrollForward: NestedScrollMode.SELF_FIRST,
              scrollBackward: NestedScrollMode.PARENT_FIRST
            },
            itemView: (item, index) => {
              this.listItem(item as Follow, index)
            },
            refresh: async () => {
              await this.refresh()
            },
            loading: async () => {
              await this.loading()
            },
          })
        }

      }
      .padding({ right: 20, left: 20 })
    }
    .hideTitleBar(true)
  }

  @Builder
  listItem(item: Follow, index: number) {
    Row({ space: 10 }) {
      Image(item.avatar).alt($r('app.media.image_error'))
        .width(50)
        .height(50)
        .borderRadius(50)
      Column({ space: 5 }) {
        Text(item.nickname)
          .fontWeight(FontWeight.Bold)
        Text(item.sign || "无签名")
          .fontSize(13)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
  }
}