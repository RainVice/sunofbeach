import { ChildNode } from 'domhandler'

@Component
export struct HHr {
  node: ChildNode | undefined = undefined
  build() {
    Divider()
  }
}