import { ChildNode, isTag } from 'domhandler'

@Component
export struct HImage {
  @Require @Prop node: ChildNode
  build() {
    if (isTag(this.node)){
      Image(this.node.attribs["src"])
    }
  }
}