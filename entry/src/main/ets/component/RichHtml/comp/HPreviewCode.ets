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
        }, (item: ChildNode) => item.toString())
      }
    }
    .padding(10)
    .backgroundColor("#ffdddddd")
  }
}