import { content } from '../../../../api'
import { NavArticle, FULL_PERCENT, NavUserPage } from '../../../../constants'
import { RouterParams } from '../../../../view_model'

@Component
export struct ArticleCard {
  @Require @Prop ctContent: content.CtContent
  @Consume navPathStack: NavPathStack

  build() {
    if (this.ctContent) {
      Column({ space: 15 }) {
        Flex() {
          ForEach(this.ctContent.covers, (item: string, index: number) => {
            Image(item).width(FULL_PERCENT).height(150)
          })
        }.width(FULL_PERCENT)

        Column({ space: 15 }) {
          // 标题
          Text(this.ctContent.title).fontWeight(FontWeight.Bold).fontColor($r('app.color.first_text'))
            .textAlign(TextAlign.Start)
          Row({ space: 10 }) {
            Row({ space: 10 }){
              // 头像
              Image(this.ctContent.avatar).height(20).width(20).autoResize(true).borderRadius(100)
              // 昵称
              Text(this.ctContent.nickName).fontSize(12).fontColor($r('app.color.second_text'))
            }
            .onClick(() => {
              this.navPathStack.pushPath({
                name: NavUserPage,
                param: { uid: this.ctContent.userId } as RouterParams
              })
            })
            // 时间
            Text(this.ctContent.createTime).fontSize(12).fontColor($r('app.color.second_text'))
            if (this.ctContent.viewCount){
              Text() {
                ImageSpan($r('app.media.ic_controlcenter_eyeconfort_filled')).height(15).width(15)
                Span(this.ctContent.viewCount.toString())
              }.fontSize(12).fontColor($r('app.color.second_text'))
            }

            Text() {
              ImageSpan($r('app.media.ic_public_thumbsup')).height(15).width(15)
              Span(this.ctContent.thumbUp.toString())
            }.fontSize(12).fontColor($r('app.color.second_text'))
          }
        }.padding({ left: 10, right: 10 ,bottom: 15})
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .width(FULL_PERCENT)
      .borderRadius(5)
      .backgroundColor(Color.White)
      .clip(true)
      .onClick(() => {
        this.navPathStack.replacePath({
          name: NavArticle,
          param: this.ctContent
        })
      })
    }
  }
}