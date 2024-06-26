import { DomUtils } from '@ohos/htmlparser2'
import { ChildNode, hasChildren, isTag } from 'domhandler'
import { RichHtmlBuilder } from '../RichHtmlBuilder'
import { HParagraph } from './HParagraph'

@Component
export struct HList {
  node: ChildNode | undefined = undefined
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
      } else if (isTag(this.node) && this.node.name === 'ul') {
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
  node: ChildNode | undefined = undefined
  order: number | undefined = undefined

  build() {
    Row({ space: 5 }) {
      Text(this.order + ".")
        .constraintSize({
          minWidth: 20
        })
        .textAlign(TextAlign.End)
      if (DomUtils.getElementsByTagName('p', this.node, true).length) {
        HParagraph({ node: DomUtils.getElementsByTagName('p', this.node, true)[0] })
      } else {
        RichHtmlBuilder({ node: this.node })
      }
    }
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct ULi {
  node: ChildNode | undefined = undefined

  build() {
    Row({ space: 5 }) {
      Text("·")
      if (DomUtils.getElementsByTagName('p', this.node, true).length) {
        HParagraph({ node: DomUtils.getElementsByTagName('p', this.node, true)[0] })
      } else {
        RichHtmlBuilder({ node: this.node })
      }
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Top)
  }
}