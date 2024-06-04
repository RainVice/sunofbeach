import { ChildNode, hasChildren, isTag } from 'domhandler'
import { RichHtmlBuilder } from '../RichHtmlBuilder'

@Component
export struct HList {
  @Require @Prop node: ChildNode
  order: number = 1

  build() {
    Column({ space: 5 }) {
      if (isTag(this.node) && this.node.name === 'ol') {
        if (hasChildren(this.node)) {
          ForEach(this.node.children, (item: ChildNode) => {
            if (isTag(item) && item.name === 'li') {
              OLi({ node: item, order: this.order++ })
            }
          }, (item: ChildNode, index: number) => item.toString() + index)
        }
      }
      else if (isTag(this.node) && this.node.name === 'ul') {
        if (hasChildren(this.node)) {
          ForEach(this.node.children, (item: ChildNode) => {
            if (isTag(item) && item.name === 'li') {
              ULi({ node: item })
            }
          }, (item: ChildNode, index: number) => item.toString() + index)
        }
      }
    }
  }
}

@Component
struct OLi {
  @Require @Prop node: ChildNode
  @Require @Prop order: number

  build() {
    Row({ space: 5 }) {
      Text(this.order + ".")
        .constraintSize({
          minWidth: 20
        })
        .textAlign(TextAlign.End)
      RichHtmlBuilder({ node: this.node })
    }
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct ULi {
  @Require @Prop node: ChildNode

  build() {
    Row({ space: 5 }) {
      Text("·")
      RichHtmlBuilder({ node: this.node })
    }
    .alignItems(VerticalAlign.Top)
  }
}