import { ChildNode } from 'domhandler'
import { HInline } from './HInline'

@Component
export struct HHeading {
  @Require @Prop node: ChildNode
  @Require @Prop level: number = 1

  build() {
    HInline({ node: this.node, fontSize: 26 - this.level * 1, fontWeight: FontWeight.Bold })
      .width("100%")
      .padding({bottom: 5})
      // .borderColor("#ffc3c3c3")
      // .borderWidth({bottom: 1})
  }
}