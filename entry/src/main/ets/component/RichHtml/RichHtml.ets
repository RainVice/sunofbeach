import { Document, parseDocument } from '@ohos/htmlparser2'
import { RichHtmlBuilder } from './RichHtmlBuilder'


@Component
export struct RichHtml {
  content: string = ''
  dom: Document | undefined = undefined

  aboutToAppear(): void {
    this.dom = parseDocument(this.content.trim())
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
