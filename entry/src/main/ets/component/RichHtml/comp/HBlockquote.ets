import { ChildNode } from 'domhandler'
import { RichHtmlBuilder } from '../RichHtmlBuilder'

@Component
export struct HBlockquote {
  node: ChildNode | undefined = undefined
  build() {
    Column() {
      RichHtmlBuilder({node: this.node})
    }.border({
      width: {
        left: 3
      },
      color: Color.Blue
    })
    .alignItems(HorizontalAlign.Start)
    .padding(10)
    .width("100%")
  }
}