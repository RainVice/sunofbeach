import { Document, parseDocument } from '@ohos/htmlparser2'
import { RichHtmlBuilder } from './RichHtmlBuilder'


@Component
export struct RichHtml {
  @Require @Prop content: string
  @State private dom: Document | null = null
  aboutToAppear(): void {
    this.dom = parseDocument(this.content)
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
