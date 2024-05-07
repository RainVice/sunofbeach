import { FULL_PERCENT } from '../constants'
import { SwipeRefresher } from '@ohos.arkui.advanced.SwipeRefresher'
import { ListAdapter } from '../utils'

@Component
export struct RefreshList {
  topDistance: number = 0
  bottomDistance: number = 0
  space: number = 10
  @Prop hasNext: boolean
  @Link listAdapter: ListAdapter<object>
  @BuilderParam itemView: (item: object, index: number) => void
  /**
   * 刷新事件
   */
  refresh: () => Promise<void> = async () => {
  }
  /**
   * 加载事件
   */
  loading: () => Promise<void> = async () => {
  }
  @State private isRefreshing: boolean = false
  @State private isLoading: boolean = false
  private listScroller: ListScroller = new ListScroller()

  build() {
    if (this.listAdapter) {
      Refresh({ refreshing: $$this.isRefreshing }) {
        List({ space: this.space, scroller: this.listScroller }) {
          ListItem()
          // ListItem().height(this.topDistance)
          // if (this.isRefreshing) {
          //   ListItem() {
          //     SwipeRefresher({
          //       content: "刷新中",
          //       isLoading: true
          //     })
          //   }
          // }
          LazyForEach(this.listAdapter, (item: object, index: number) => {
            ListItem() {
              this.itemView(item, index)
            }
          })
          if (this.isLoading && this.hasNext) {
            ListItem() {
              SwipeRefresher({
                content: "加载中",
                isLoading: true
              })
            }
          }
          if (!this.hasNext) {
            ListItem(){
              Row(){
                Text("没有更多了")
                  .fontSize(12)
                  .fontColor($r('app.color.third_text'))
              }.width(FULL_PERCENT)
              .justifyContent(FlexAlign.Center)

            }
          }
          ListItem().height(this.bottomDistance)
        }
        .padding({
          left: 10,
          right: 10
        })
        .scrollBar(BarState.Off)
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.PARENT_FIRST
        })
        // .height(FULL_PERCENT)
        .width(FULL_PERCENT)
        // .onReachStart(async () => {
        //   if (this.isLoading || this.isRefreshing) {
        //     return
        //   }
        //   this.isRefreshing = true
        //   await this.refresh()
        //   this.isRefreshing = false
        // })
        .onReachEnd(async () => {
          if (this.isLoading || this.isRefreshing) {
            return
          }
          this.isLoading = true
          await this.loading()
          this.isLoading = false
        })
      }
      .backgroundColor($r('app.color.list_back'))
      .onRefreshing(async () => {
        await this.refresh()
        this.isRefreshing = false
      })
      .padding({top: this.topDistance})
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)

    }
  }
}