import { IndexHeader, IndexItem } from '../../../view_model'
import { promptAction } from '@kit.ArkUI'

@Component
export struct Header {

  @Prop menuItem: IndexHeader[] = []

  build() {

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

      ForEach(this.menuItem,(item: IndexHeader,index: number)=> {
        Image(item.image)
          .width(20)
          .height(20)
          .onClick(() => {
            item.action()
          })
          .gesture(LongPressGesture()
            .onAction(() => {
              if (item.description) {
                promptAction.showToast({message: item.description})
              }
            }))
      })

    }
    .padding({left: 15,right: 15,top: 5,bottom: 5})
    .justifyContent(FlexAlign.Start)

  }
}