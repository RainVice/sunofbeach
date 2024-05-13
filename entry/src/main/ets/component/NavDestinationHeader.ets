import { FULL_PERCENT } from '../constants'

@Component
export struct NavDestinationHeader {
  @BuilderParam builderItem: () => void
  @Consume navPathStack: NavPathStack

  build() {
    Row({ space: 10 }) {
      Image($r('sys.media.ohos_ic_back')).width(20).height(20).onClick(() => {
        this.navPathStack.pop()
      })
      if (this.builderItem) {
        this.builderItem()
      }
    }
    .height(56)
    .justifyContent(FlexAlign.Start)
    .width(FULL_PERCENT)
  }
}