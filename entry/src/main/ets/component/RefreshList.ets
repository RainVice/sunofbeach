import { FULL_PERCENT } from '../constants'
import { SwipeRefresher } from '@ohos.arkui.advanced.SwipeRefresher'
import { ListAdapter } from '../utils'

@Component
export struct RefreshList {
  topDistance: number = 0
  bottomDistance: number = 0
  leftDistance: number = 0
  rightDistance: number = 0
  bgColor: ResourceColor | undefined = undefined
  space: number = 10
  nestedScrollOptions: NestedScrollOptions = {
    scrollForward: NestedScrollMode.PARENT_FIRST,
    scrollBackward: NestedScrollMode.PARENT_FIRST
  }
  needRefresh: boolean = true
  @Prop hasNext: boolean
  @Link listAdapter: ListAdapter<object | string | number | boolean>
  @BuilderParam itemView: (item: object | string | number | boolean, index: number) => void
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
      if (this.needRefresh) {
        Refresh({ refreshing: $$this.isRefreshing }) {
          this.list()
        }
        .backgroundColor(this.bgColor)
        .onRefreshing(async () => {
          await this.refresh()
          this.isRefreshing = false
        })
        .padding({ top: this.topDistance })
        .width(FULL_PERCENT)
        .height(FULL_PERCENT)
      }else{
        this.list()
      }


    }
  }

  @Builder
  list(){
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
        ListItem() {
          Row() {
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
      left: this.leftDistance,
      right: this.rightDistance
    })
    .height(FULL_PERCENT)
    .scrollBar(BarState.Off)
    .nestedScroll(this.nestedScrollOptions)
    .width(FULL_PERCENT)
    .onReachEnd(async () => {
      if (this.isLoading || this.isRefreshing) {
        return
      }
      this.isLoading = true
      await this.loading()
      this.isLoading = false
    })
  }
}