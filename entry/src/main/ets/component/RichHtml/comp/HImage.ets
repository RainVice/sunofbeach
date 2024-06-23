import { ChildNode, isTag } from 'domhandler'

@Component
export struct HImage {
  node: ChildNode | undefined = undefined
  build() {
    if (isTag(this.node)){
      Image(this.node.attribs["src"])
    }
  }
}