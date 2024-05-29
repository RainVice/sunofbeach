import { wenda } from '../../../../api'
import { FULL_PERCENT } from '../../../../constants'

@Component
export struct QuestionCard {
  @Require @Prop content: wenda.WenDaList
  @Consume navPathStack: NavPathStack

  build() {
    if (this.content) {
      Column({ space: 10 }) {
        // 头像
        Row({ space: 10 }) {
          Image(this.content?.avatar)
            .width(30)
            .height(30)
            .borderRadius(100)
            .autoResize(true)
            .alt($r('app.media.image_error'))
          Column({ space: 2 }) {
            Text(this.content?.nickname).fontWeight(FontWeight.Bold)
              .fontColor(this.content?.isVip === "1" ? $r('app.color.vip') : $r('app.color.second_text'))
              .fontSize(14)
            Text(this.content?.createTime)
              .fontSize(10)
              .fontColor($r('app.color.third_text'))

          }
          .height(30)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)

          Blank()
          if (this.content.isResolve === "1") {
            Text("已解决").fontSize(13).fontColor($r('app.color.auxiliary')).fontWeight(FontWeight.Bold)
          }else{
            Text("未解决").fontSize(13).fontColor($r('app.color.second_text')).fontWeight(FontWeight.Bold)
          }
        }
        .justifyContent(FlexAlign.Start)
        .width(FULL_PERCENT)

        Text(this.content.title).fontWeight(FontWeight.Bold).fontSize(14)

        Flex() {
          ForEach(this.content.labels, (item: string, index: number) => {
            Text(item)
              .padding(5)
              .margin(3)
              .fontSize(12)
              .fontColor($r('app.color.second_text'))
              .backgroundColor("#ecf5ff")
          })
        }

        Divider()
        Row() {
          Row({ space: 5 }) {
            Image($r('app.media.ic_controlcenter_eyeconfort_filled')).width(15).height(15)
            Text(`${this.content?.viewCount}`)
              .fontSize(13)
          }.layoutWeight(1)
          .justifyContent(FlexAlign.Center)

          Divider()
            .vertical(true)

          Row({ space: 5 }) {
            Image($r('app.media.ic_public_comments')).width(15).height(15)
            Text(`${this.content?.answerCount}`)
              .fontSize(13)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)

          Divider()
            .vertical(true)

          Row({ space: 5 }) {
            Image($r('app.media.ic_public_share')).width(15).height(15)
            Text($r('app.string.share'))
              .fontSize(13)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }.height(20)

      }
      .alignItems(HorizontalAlign.Start)
      .width(FULL_PERCENT)
      .borderRadius(5)
      .backgroundColor(Color.White)
      .padding(10)
      .onClick(() => {
        // todo 跳转到问答详情
      })

    }
  }
}