import { Layout } from '../../constants/index'
import { IndexItem, indexItems } from '../../view_model'

@Entry
@Component
struct Index {

  @State toolBarIndex: number = 0

  build() {
    Column() {
      Navigation() {
        Scroll() {

        }.height(1000)
        .width(Layout.FULL_PERCENT)
      }
      .menus(indexItems[this.toolBarIndex].menu)
      .title(indexItems[this.toolBarIndex].title)
      .toolbarConfiguration(this.toolBar())
    }.width(Layout.FULL_PERCENT)
    .height(Layout.FULL_PERCENT)
  }

  @Builder
  toolBar() {
    Row() {
      ForEach(indexItems, (item: IndexItem, index: number) => {
        Column({space: 2}) {
          Image(item.icon)
            .width(20)
            .height(20)
            .fillColor(index === this.toolBarIndex ? $r('app.color.selected_background_for_component') : $r('app.color.not_selected_background_for_component') )
          Text(item.title)
            .fontSize(10)
            .fontColor($r('app.color.not_selected_background_for_component'))
        }
        .onClick(() => {
          this.toolBarIndex = index
        })
        .layoutWeight(1)
      })
    }
  }
}

