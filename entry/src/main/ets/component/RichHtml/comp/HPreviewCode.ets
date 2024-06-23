import { ChildNode, hasChildren } from 'domhandler'
import { FULL_PERCENT } from '../../../constants'
import { HInline } from './HInline'

@Component
export struct HPreviewCode {
  node: ChildNode | undefined = undefined

  build() {
    Scroll(){
      Column({space: 5}) {
        if (hasChildren(this.node)) {
          ForEach(this.node.children, (item: ChildNode) => {
            HInline({ node: item })
          }, (item: ChildNode, index: number) => item.toString() + index)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding(10)
    }
    .backgroundColor("#f0f0f0")
    .align(Alignment.Start)
    .scrollBarWidth(2)
    .width(FULL_PERCENT)
    .scrollable(ScrollDirection.Horizontal)
  }
}


