import { ChildNode } from 'domhandler'
import { HInline } from './HInline'

@Component
export struct HParagraph {
  @Require @Prop node: ChildNode
  build() {
    HInline({node: this.node})
  }
}