import { FULL_PERCENT } from '../../constants'
import { IndexItem, indexItems } from '../../view_model'
import { Article } from './Article/Article'
import { Dawdling } from './Dawdling/Dawdling'
import { Question } from './Question/Question'
import { User } from './User/User'

@Entry
@Component
struct Index {
  @State toolBarIndex: number = 0

  build() {
    Column() {
      Navigation() {
        Tabs({ barPosition: BarPosition.End, index: $$this.toolBarIndex }) {
          ForEach(indexItems, (item: IndexItem, index: number) => {
            TabContent() {
              Scroll() {
                Column() {
                  Row({ space: 15 }) {
                    Image(null).borderRadius(100)
                      .width(30)
                      .height(30)
                      .backgroundColor(Color.Black)
                    Search({
                      placeholder: "输入搜索内容"
                    })
                      .placeholderFont({
                        size: 12
                      })
                      .backgroundColor(null)
                      .layoutWeight(1)
                      .height(30)

                    Image($r('app.media.ic_public_community_messages'))
                      .width(20)
                      .height(20)

                    Image($r('app.media.ic_public_add_filled'))
                      .width(20)
                      .height(20)
                  }
                  .padding({left: 15,right: 15,top: 5,bottom: 5})
                  .justifyContent(FlexAlign.Start)

                  if (index === 0) {
                    Dawdling()
                  }
                  else if (index === 1) {
                    Article()
                  }
                  else if (index === 2) {
                    Question()
                  }
                  else if (index === 3) {
                    User()
                  }

                }
                .justifyContent(FlexAlign.Start)
              }
            }
            .tabBar(this.toolBar(index))
          })
        }
        .height(FULL_PERCENT)
        .width(FULL_PERCENT)
        .barOverlap(true)
        .barBackgroundBlurStyle(BlurStyle.Thin)
        .barBackgroundColor($r("app.color.background_color"))
      }
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
      .hideTitleBar(true)
    }.width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }

  @Builder
  toolBar(index: number) {
    Row() {
      Column({ space: 2 }) {
        Image(indexItems[index].icon)
          .width(20)
          .height(20)
          .fillColor(index === this.toolBarIndex ? $r('app.color.selected_background_for_component') : $r('app.color.not_selected_background_for_component'))
        Text(indexItems[index].title)
          .fontSize(10)
          .fontColor($r('app.color.not_selected_background_for_component'))
      }
    }
  }
}