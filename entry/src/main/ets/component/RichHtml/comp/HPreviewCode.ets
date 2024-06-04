import { ChildNode, hasChildren } from 'domhandler'
import { HInline } from './HInline'

@Component
export struct HPreviewCode {
  @Require @Prop node: ChildNode

  build() {
    Column({space: 5}) {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          HInline({ node: item })
        }, (item: ChildNode, index: number) => item.toString() + index)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(10)
    .width("100%")
    .backgroundColor("#ffdddddd")
  }
}