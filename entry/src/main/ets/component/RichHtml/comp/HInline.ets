import { DomUtils, ElementType } from '@ohos/htmlparser2'
import { ChildNode, Element, hasChildren, isTag, isText, Text as DomText } from 'domhandler'
import { promptAction, router } from '@kit.ArkUI'
import { RouterParams } from '../../../view_model'

@Component
export struct HInline {
  node: ChildNode | undefined = undefined
  fontSize: number = 16
  fontWeight: FontWeight = FontWeight.Normal
  fontStyle: FontStyle = FontStyle.Normal
  @Consume images: string[]

  build() {
    if (hasChildren(this.node)) {
      Text() {
        ForEach(this.node.children, (item: ChildNode) => {
          if (isText(item)) {
            Span(item.data.trim())
          }
          else if (isTag(item) && item.name === 'img') {
            ImageSpan(item.attribs["src"])
              .onClick(() => {
                const src: string = (this.node as Element).attribs["src"]
                const imageIndex = this.images.findIndex((item => item === src))
                router.pushUrl({
                  url: 'pages/ImagePreview/ImagePreview',
                  params: { imageUrls: this.images, imageIndex: imageIndex } as RouterParams
                })
              })
          }
          else if (isTag(item) && item.name === 'a') {
            Span(DomUtils.textContent(item).trim())
              .fontColor(Color.Blue)
              .onClick(() => {
                promptAction.showToast({
                  message: "跳转url： " + item.attribs["href"]
                })
              })
          }
          else if (isTag(item) && (item.name === 'code' || item.name === 'b' || item.name === 'strong' || item.name === 'i' || item.name === 'em')) {
            // Span(" ")
            if (DomUtils.getElementsByTagType(ElementType.Text, item)?.length > 0) {
              Span((DomUtils.getElementsByTagType(ElementType.Text, item)[0] as DomText).data.trim())
                .fontWeight(DomUtils.getElementsByTagName("b", item, true)
                  .length > 0 || DomUtils.getElementsByTagName("strong", item, true)
                  .length > 0 ? FontWeight.Bold : FontWeight.Normal)
                .fontStyle(DomUtils.getElementsByTagName("i", item, true)
                  .length > 0 || DomUtils.getElementsByTagName("em", item, true)
                  .length > 0 ? FontStyle.Italic : FontStyle.Normal)
                .textBackgroundStyle(DomUtils.getElementsByTagName("code", item, true).length > 0 ? {
                  color: "#ffe3e3e3",
                  radius: 2
                } : {
                  color: Color.Transparent,
                  radius: 0
                })
                .fontColor(DomUtils.getElementsByTagName("code", item, true).length > 0 ? "#ffee421e" : "#ff000000")
            }
            // Span(" ")
          }
        }, (item: ChildNode, index: number) => item.toString() + index)
      }
      .fontSize(this.fontSize)
      .fontWeight(this.fontWeight)
      .fontStyle(this.fontStyle)
    } else if (isText(this.node) && this.node.data.trim()) {
      Text(this.node.data.trim())
        .fontSize(this.fontSize)
        .fontWeight(this.fontWeight)
        .fontStyle(this.fontStyle)
    }
  }
}



