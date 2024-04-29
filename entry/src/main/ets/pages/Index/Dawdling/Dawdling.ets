import { moyu } from '../../../api';
import { FULL_PERCENT } from '../../../constants';
import { TabBar } from '../component/TabBar';
import { DawdlingContent } from './Content/DawdlingContent';

@Component
export struct Dawdling {
  /**
   * 话题
   */
  @State topic: moyu.TopicIndex[] = []
  @State currentIndex: number = 1

  async aboutToAppear(): Promise<void> {
    this.topic = await moyu.topic()
  }

  build() {
    Column() {
      if (this.topic.length){
        Tabs({ index: $$this.currentIndex }) {
          ForEach(this.topic, (item: moyu.TopicIndex, index: number) => {
            TabContent() {
              // Scroll() {
              //   Column({ space: 10 }) {
              //     CardComponent({title: "热门"}){
              //
              //     }
              //     Divider()
              //     CardComponent({title: "推荐"}){
              //
              //     }
              //   }
              //   .alignItems(HorizontalAlign.Start)
              //   .padding({
              //     left: 20,
              //     right: 20,
              //     top: 35,
              //     bottom: 56
              //   })
              // }
              // List(){
              //   ListItem().height(35)
              //
              //
              //
              //   ListItem().height(56)
              // }
              // .padding({
              //   left: 20,
              //   right: 20,
              // })
              // .nestedScroll({
              //   scrollForward: NestedScrollMode.PARENT_FIRST,
              //   scrollBackward: NestedScrollMode.SELF_FIRST
              // })
              // .width(FULL_PERCENT)
              DawdlingContent({topicInfo: item})
            }
            .align(Alignment.TopStart)
            .tabBar(this.tabBar(item.topicName, index))
          })
        }
        .barMode(BarMode.Scrollable, { margin: 10 })
        .barHeight(35)
        .barOverlap(true)
        .barBackgroundBlurStyle(BlurStyle.Thin)
        .barBackgroundColor($r("app.color.background_color"))
      }
    }
    .height(FULL_PERCENT)
    .width(FULL_PERCENT)

  }


  @Builder
  tabBar(name: string, index: number) {
    TabBar({
      currentIndex: this.currentIndex,
      name,
      index
    })
  }
}