import { ChildNode, hasChildren, isTag, isText } from 'domhandler'
import { HBlockquote } from './comp/HBlockquote'
import { HHeading } from './comp/HHeading'
import { HHr } from './comp/HHr'
import { HInline } from './comp/HInline'
import { HParagraph } from './comp/HParagraph'
import { HPreviewCode } from './comp/HPreviewCode'

@Component
export struct RichHtmlBuilder {
  @Require @Prop node: ChildNode

  build() {
    Column({ space: 10 }) {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode, index: number) => {
          if (isTag(item)) {
            if (item.name === 'h1') {
              HHeading({ node: item, level: 1 })
            }
            else if (item.name === 'h2') {
              HHeading({ node: item, level: 2 })
            }
            else if (item.name === 'h3') {
              HHeading({ node: item, level: 3 })
            }
            else if (item.name === 'h4') {
              HHeading({ node: item, level: 4 })
            }
            else if (item.name === 'h5') {
              HHeading({ node: item, level: 5 })
            }
            else if (item.name === 'h6') {
              HHeading({ node: item, level: 6 })
            }
            else if (item.name === 'p') {
              HParagraph({ node: item })
            }
            else if (item.name === 'blockquote') {
              HBlockquote({ node: item })
            }
            else if (item.name === 'hr') {
              HHr({ node: item })
            }
            else if (item.name === 'pre') {
              HPreviewCode({ node: item })
            }
          }
          else if (isText(item) && item.data.trim()) {
            HInline({ node: item })
          }
        }, (item: ChildNode) => item.toString())
      }
    }
    .width("100%")
    .alignItems(HorizontalAlign.Start)
  }
}