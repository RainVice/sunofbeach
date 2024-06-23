import { FULL_PERCENT } from '../constants'
import { router } from '@kit.ArkUI'
import { emptyBuilder } from '.'

@Component
export struct TitleBar {
  @BuilderParam builderItem: () => void = emptyBuilder

  build() {
    Row({ space: 10 }) {
      Image($r('sys.media.ohos_ic_back')).width(20).height(20).onClick(() => {
        router.back()
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