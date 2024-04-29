import { FULL_PERCENT } from '../../../constants'

@Component
export struct TabBar {
  @Prop currentIndex:number = 0
  name: string = ""
  index: number = 0

  build() {
    Column({ space: 2 }) {
      Text(this.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentIndex === this.index ?
        $r('app.color.selected_background_for_component') :
        $r('app.color.not_selected_background_for_component'))
      if (this.currentIndex === this.index) {
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