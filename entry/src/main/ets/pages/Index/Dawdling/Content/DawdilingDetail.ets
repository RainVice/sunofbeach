import { moyu } from '../../../../api'
import { DawsilingContent } from './DawdilingContent'
import { Dawdiling, FULL_PERCENT } from '../../../../constants'


export interface DawdilingDetailData {
  moyuContent: moyu.MoyuContent
  content: string
}

// todo 完善评论
@Component
export struct DawdilingDetail {
  @State moyuContent: moyu.MoyuContent | undefined = undefined
  @State content: string | undefined = undefined
  @Consume navPathStack: NavPathStack

  build() {
    NavDestination() {
      if (this.moyuContent) {
        Column({ space: 10 }) {
          Row({ space: 10 }) {

            Image($r('sys.media.ohos_ic_back')).width(20).height(20).onClick(() => {
              this.navPathStack.pop()
            })

            Image(this.moyuContent?.avatar).width(30).height(30).borderRadius(100)
            Column({ space: 5 }) {
              Text(this.moyuContent?.nickname).fontWeight(FontWeight.Bold)
                .fontSize(12)
                .fontColor(this.moyuContent?.vip ? $r('app.color.vip') : $r('app.color.first_text'))
              Text(this.moyuContent?.createTime)
                .fontSize(10)
                .fontColor($r('app.color.second_text'))
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
            Text($r('app.string.follow'))
              .fontSize(10)
              .fontColor($r('app.color.auxiliary'))
              .padding({
                right: 10, left: 10,
                top: 5, bottom: 5
              })
              .borderRadius(100)
              .border({
                color: $r('app.color.auxiliary'),
                width: 1
              })
            Image($r('app.media.ic_public_more_filled'))
              .width(20)
              .height(20)
          }
          .height(56)
          .width(FULL_PERCENT)

          Scroll() {
            Column({ space: 10 }) {
              DawsilingContent({ moyuContent: this.moyuContent, content: this.content })
              Divider()
              // 评论
              Column(){

              }
                .height(FULL_PERCENT)
                .width(FULL_PERCENT)

            }
          }.layoutWeight(1)
        }
        .padding(10)
      }
    }.hideTitleBar(true)
    .onReady((ctx: NavDestinationContext) => {
      const data: DawdilingDetailData = ctx.pathInfo.param as DawdilingDetailData
      this.moyuContent = data.moyuContent
      this.content = data.content
    })

  }
}