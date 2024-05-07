import { moyu } from '../../../api';
import { FULL_PERCENT } from '../../../constants';
import { TabBar } from '../component/TabBar';
import { DawdlingList } from './Content/DawdlingList';

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
              DawdlingList({topicInfo: item})
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