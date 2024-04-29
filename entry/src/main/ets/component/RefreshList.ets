import { FULL_PERCENT } from '../constants'
import { SwipeRefresher } from '@ohos.arkui.advanced.SwipeRefresher'
import { ListAdapter } from '../utils'

@Component
@Preview
export struct RefreshList {
  topDistance: number = 0
  bottomDistance: number = 0
  space: number = 10
  @Prop listAdapter: ListAdapter<object>
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

  build() {
    List({ space: this.space }) {
      ListItem().height(this.topDistance)
      if (this.isRefreshing) {
        ListItem() {
          SwipeRefresher({
            content: "刷新中",
            isLoading: true
          })
        }
      }
      LazyForEach(this.listAdapter, (item: object, index: number) => {
        ListItem() {
          this.itemView(item, index)
        }
      })
      if (this.isLoading) {
        ListItem() {
          SwipeRefresher({
            content: "加载中",
            isLoading: true
          })
        }
      }
      ListItem().height(this.bottomDistance)
    }
    .padding({
      left: 10,
      right: 10
    })
    .backgroundColor($r('app.color.list_back'))
    .scrollBar(BarState.Off)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
    // .height(FULL_PERCENT)
    .width(FULL_PERCENT)
  }
}