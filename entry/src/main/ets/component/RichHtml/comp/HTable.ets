import { DomUtils } from '@ohos/htmlparser2'
import { it } from '@ohos/hypium'
import { ChildNode, hasChildren, isTag } from 'domhandler'
import { HInline } from './HInline'

@Component
export struct HTable {
  node: ChildNode | undefined = undefined

  build() {
    Column() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          if (isTag(item)) {
            if (item.name === 'thead') {
              ForEach(item.children.filter(i => isTag(i)), (th: ChildNode, thi: number) => {
                Row() {
                  if (hasChildren(th)) {
                    ForEach(th.children, (td: ChildNode) => {
                      HInline({ node: td, fontWeight: FontWeight.Bold })
                        .padding(10)
                        .layoutWeight(1)
                    }, (td: ChildNode, tdi: number) => td.toString() + tdi)
                  }
                }
                .backgroundColor(thi % 2 === 0 ? "#F0F0F0" : Color.Transparent)
              }, (th: ChildNode, thi: number) => th.toString() + thi)
            }
            else if (item.name === 'tbody') {
              ForEach(item.children.filter(i => isTag(i)), (tr: ChildNode, tri: number) => {
                Row() {
                  if (hasChildren(tr)) {
                    ForEach(tr.children, (td: ChildNode) => {
                      HInline({ node: td })
                        .padding(10)
                        .layoutWeight(1)
                    }, (td: ChildNode, tdi: number) => td.toString() + tdi)
                  }
                }
                .backgroundColor(tri % 2 === 0 ? Color.Transparent : "#F0F0F0")
              }, (tr: ChildNode, tri: number) => tr.toString() + tri)
            }
          }
        }, (item: ChildNode, index: number) => item.toString() + index)
      }
    }
  }
}