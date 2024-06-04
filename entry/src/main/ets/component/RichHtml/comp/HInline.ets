import { ChildNode, hasChildren, isText } from 'domhandler'

@Component
export struct HInline {
  @Require @Prop node: ChildNode
  @Prop fontSize: number = 16
  @Prop fontWeight: FontWeight = FontWeight.Normal
  @Prop fontStyle: FontStyle = FontStyle.Normal

  build() {
    if (hasChildren(this.node)) {
      Text() {
        ForEach(this.node.children, (item: ChildNode, index: number) => {
          if (isText(item)) {
            Span(item.data.trim())
          }
        }, (item: ChildNode) => item.toString())
      }
      .fontSize(this.fontSize)
      .fontWeight(this.fontWeight)
      .fontStyle(this.fontStyle)
    }
    else if (isText(this.node) && this.node.data.trim()) {
      Text(this.node.data.trim())
        .fontSize(this.fontSize)
        .fontWeight(this.fontWeight)
        .fontStyle(this.fontStyle)
    }
  }
}
