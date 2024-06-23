import { Document, DomUtils, parseDocument } from '@ohos/htmlparser2'
import { RichHtmlBuilder } from './RichHtmlBuilder'


@Component
export struct RichHtml {
  content: string = ''
  dom: Document | undefined = undefined
  @Provide images: string[] = []

  aboutToAppear(): void {
    this.dom = parseDocument(this.content.trim())
    this.images = DomUtils.getElementsByTagName("img", this.dom, true).map(image => image.attribs["src"])
  }

  build() {
    Column({ space: 10 }) {
      if (this.dom) {
        RichHtmlBuilder({ node: this.dom })
      }
    }
    .padding(10)
    .alignItems(HorizontalAlign.Start)
    .width("100%")
  }
}
