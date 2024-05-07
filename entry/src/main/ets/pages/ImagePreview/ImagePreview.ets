import { router } from '@kit.ArkUI'
import { ImagePreView, ImagePreViewOption } from '@rv/image-preview'
import { FULL_PERCENT } from '../../constants'
import { disableFullScreen, enableFullScreen } from '../../utils'
import { RouterParams } from '../../view_model'

@Entry
@Component
struct ImagePreview {
  params: RouterParams = router.getParams() as RouterParams
  @State urls: string[] | undefined = this.params.imageUrls
  @State imagePreViewOption: ImagePreViewOption = new ImagePreViewOption(this.urls as string[])

  async aboutToAppear(): Promise<void> {
    enableFullScreen()
    this.imagePreViewOption.setShowIndex(this.params.imageIndex)
  }

  async aboutToDisappear(): Promise<void> {
    disableFullScreen()
  }

  build() {
    Column() {
      if (this.urls) {
        ImagePreView({
          option: this.imagePreViewOption
        })
          .height(FULL_PERCENT)
          .width(FULL_PERCENT)
      }
    }
    .width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }
}