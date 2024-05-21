import { FULL_PERCENT } from '../../../constants'
import { WenDaTab, wendaTabs } from '../../../view_model'
import { TabBar } from '../component/TabBar'
import { QuestionList } from './Content/QuestionList'

@Component
export struct Question {
  @State currentIndex: number = 0

  build() {
    Column() {
      Tabs({ index: $$this.currentIndex }) {
        ForEach(wendaTabs, (item: WenDaTab, index: number) => {
          TabContent() {
            QuestionList({
              state: item.state
            })
          }
          .align(Alignment.TopStart)
          .tabBar(this.tabBar(item.name, index))
        })
      }
      .barMode(BarMode.Scrollable, { margin: 10 })
      .barHeight(35)
      .barBackgroundColor($r("app.color.background_color"))
    }.width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }

  @Builder
  tabBar(name: ResourceStr, index: number) {
    TabBar({
      currentIndex: this.currentIndex,
      name,
      index
    })
  }
}