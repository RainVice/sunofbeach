import { ct } from '../../../api'
import { FULL_PERCENT } from '../../../constants'

@Component
export struct Article {
  @State currentIndex: number = 0
  @State category: ct.Category[] = []

  async aboutToAppear(): Promise<void> {
    this.category = await ct.category()
    this.category.unshift(ct.recommend)
  }

  build() {
    Column() {

      Tabs({ index: $$this.currentIndex }) {
        ForEach(this.category, (item: ct.Category, index: number) => {
          TabContent() {
            List(){
              ListItem().height(35)

              ListItem().height(56)
            }
            .nestedScroll({
              scrollForward: NestedScrollMode.PARENT_FIRST,
              scrollBackward: NestedScrollMode.SELF_FIRST
            })
            .width(FULL_PERCENT)
          }
          .tabBar(this.tabBar(item.categoryName, index))
        })
      }
      .barMode(BarMode.Scrollable,{ margin: 10 })
      .barHeight(35)
      .barOverlap(true)
      .barBackgroundBlurStyle(BlurStyle.Thin)
      .barBackgroundColor($r("app.color.background_color"))
    }
    .height(FULL_PERCENT)
    .width(FULL_PERCENT)
  }

  @Builder
  tabBar(name: string, index: number) {
    Column({ space: 2 }) {
      Text(name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentIndex === index ?
        $r('app.color.selected_background_for_component') :
        $r('app.color.not_selected_background_for_component'))
      if (this.currentIndex === index) {
        Column().backgroundColor($r('app.color.selected_background_for_component'))
          .width(15)
          .height(2)
          .borderRadius(15)
      }
    }
    .margin({ left: 10, right: 10 })
    .justifyContent(FlexAlign.Center)
    .height(FULL_PERCENT)
  }
}