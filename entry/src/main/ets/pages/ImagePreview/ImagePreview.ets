import { router } from '@kit.ArkUI'
import { FULL_PERCENT } from '../../constants'
import { ListAdapter } from '../../utils'
import { RouterParams } from '../../view_model'

@Entry
@Component
struct ImagePreview {
  @State urls: string[] | undefined = (router.getParams() as RouterParams).imageUrls


  build() {
    Column() {
      if (this.urls) {
        Swiper() {



        }
        .width(FULL_PERCENT)
        .height(FULL_PERCENT)
      }
    }
    .width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }
}