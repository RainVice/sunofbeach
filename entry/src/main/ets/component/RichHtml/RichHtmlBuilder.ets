import { ChildNode, hasChildren, isTag, isText } from 'domhandler'
import { HBlockquote } from './comp/HBlockquote'
import { HHeading } from './comp/HHeading'
import { HHr } from './comp/HHr'
import { HImage } from './comp/HImage'
import { HInline } from './comp/HInline'
import { HList } from './comp/HList'
import { HParagraph } from './comp/HParagraph'
import { HPreviewCode } from './comp/HPreviewCode'
import { HTable } from './comp/HTable'

@Component
export struct RichHtmlBuilder {
  node: ChildNode | undefined = undefined

  build() {
    Column({ space: 10 }) {
      if (isTag(this.node) && this.node.name === 'li') {
        HInline({ node: this.node })
      }
      else if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode, index: number) => {
          if (isTag(item)) {
            if (item.name === 'h1') {
              HHeading({ node: item, level: 1 })
            } else if (item.name === 'h2') {
              HHeading({ node: item, level: 2 })
            } else if (item.name === 'h3') {
              HHeading({ node: item, level: 3 })
            } else if (item.name === 'h4') {
              HHeading({ node: item, level: 4 })
            } else if (item.name === 'h5') {
              HHeading({ node: item, level: 5 })
            } else if (item.name === 'h6') {
              HHeading({ node: item, level: 6 })
            } else if (item.name === 'p' || item.name === 'strong' || item.name === 'em' || item.name === 'i' ||
              item.name === 'b') {
              HParagraph({ node: item })
            } else if (item.name === 'blockquote') {
              HBlockquote({ node: item })
            } else if (item.name === 'hr') {
              HHr({ node: item })
            } else if (item.name === 'pre') {
              HPreviewCode({ node: item })
            } else if (item.name === 'img') {
              HImage({ node: item })
            } else if (item.name === 'ol' || item.name === 'ul') {
              HList({ node: item })
            } else if (item.name === 'table') {
              HTable({ node: item })
            }
          } else if (isText(item) && item.data.trim()) {
            HInline({ node: item })
          }
        }, (item: ChildNode, index: number) => item.toString() + index)
      }
      else if (isText(this.node) && this.node.data.trim()) {
        HInline({ node: this.node })
      }
    }
    .width("100%")
    .alignItems(HorizontalAlign.Start)
  }
}