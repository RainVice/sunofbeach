import { ChildNode, isTag } from 'domhandler'
import { router } from '@kit.ArkUI'
import { RouterParams } from '../../../view_model'


@Component
export struct HImage {
  node: ChildNode | undefined = undefined
  src: string = ''
  imageIndex: number = -1
  @Consume images: string[]

  aboutToAppear(): void {
    if (isTag(this.node)) {
      this.src = this.node.attribs["src"]
      this.imageIndex = this.images.findIndex((item => item === this.src))
    }
  }

  build() {
    Image(this.src)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ImagePreview/ImagePreview',
          params: { imageUrls: this.images, imageIndex: this.imageIndex } as RouterParams
        })
      })
      .sharedTransition(JSON.stringify(this.src) + this.imageIndex)
  }
}