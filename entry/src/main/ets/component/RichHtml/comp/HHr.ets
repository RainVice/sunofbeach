import { ChildNode } from 'domhandler'

@Component
export struct HHr {
  @Require @Prop node: ChildNode
  build() {
    Divider()
  }
}