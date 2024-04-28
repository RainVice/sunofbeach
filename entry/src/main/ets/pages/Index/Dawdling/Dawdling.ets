import { FULL_PERCENT } from '../../../constants';

@Component
export struct Dawdling {


  @State currentIndex: number = 0

  build() {

    Column() {

      Tabs({ index: $$this.currentIndex }) {

        // todo 摸鱼界面，获取摸鱼数据

      }
      .barMode(BarMode.Scrollable,{
        margin: 10
      })
      .barHeight(35)
      .barOverlap(true)
      .barBackgroundBlurStyle(BlurStyle.Thin)
      .barBackgroundColor($r("app.color.background_color"))
    }
    .height(FULL_PERCENT)
    .width(FULL_PERCENT)

  }
}