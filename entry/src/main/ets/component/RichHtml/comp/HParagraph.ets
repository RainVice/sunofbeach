import { ChildNode } from 'domhandler'
import { HInline } from './HInline'

@Component
export struct HParagraph {
  node: ChildNode | undefined = undefined
  build() {
    HInline({node: this.node})
  }
}