import { FULL_PERCENT } from '../constants'

@Component
export struct CommentInput {


  @Require @Prop pushAction: PushAction
  @Require @Prop name: string = ''
  @State private content: string = ''

  build() {
    Column({ space: 20 }) {
      Row() {
        Text("回复")
          .fontColor($r('app.color.first_text'))
        Blank()
        Text("发布")
          .fontColor(this.content ? $r("app.color.selected_background_for_component") : $r('app.color.second_text'))
          .onClick(async () => {
            if (this.content) {
              await this.pushAction.push(this.content)
            }
          })

      }.width(FULL_PERCENT)

      TextArea({text: $$this.content, placeholder: `回复${this.name}` })
        .fontColor($r('app.color.first_text'))
        .fontSize(14)
        .height(200)
        .width(FULL_PERCENT)
        .padding(0)
        .borderRadius(0)
        .backgroundColor(Color.Transparent)
    }
    .padding(20)
    .width(FULL_PERCENT)
  }
}

export interface PushAction{
  push: (content: string) => Promise<void>;
}