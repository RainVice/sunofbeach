import { moyu } from '../../../../api'
import { Dawdiling, FULL_PERCENT } from '../../../../constants'
import { createDocumentStream, Document, DomUtils } from '@ohos/htmlparser2'
import { DawsilingContent } from './DawdilingContent'
import { DawdilingDetailData } from './DawdilingDetail'

@Component
export struct DawdlingCard {
  @Prop moyuContent: moyu.MoyuContent
  @State content: string = ''
  @Consume navPathStack: NavPathStack

  aboutToAppear(): void {
    const parser = createDocumentStream((error: Error | null, dom: Document) => {
      this.content = DomUtils.textContent(dom)
    })
    parser.write(this.moyuContent?.content as string)
    parser.end()
  }

  build() {
    if (this.moyuContent) {
      Column({ space: 10 }) {
        // 头像
        Row({ space: 10 }) {
          Image(this.moyuContent?.avatar).width(30).height(30).borderRadius(100)
          Column({ space: 2 }) {
            Text(this.moyuContent?.nickname).fontWeight(FontWeight.Bold)
              .fontColor(this.moyuContent?.vip ? $r('app.color.vip') : $r('app.color.second_text'))
              .fontSize(14)
            Row({ space: 8 }) {
              Text(this.moyuContent?.position ? this.moyuContent?.position : "游民")
                .fontSize(10)
                .fontColor($r('app.color.third_text'))
              Text(this.moyuContent?.company ? this.moyuContent?.company : "无业")
                .fontSize(10)
                .fontColor($r('app.color.third_text'))
              Text(this.moyuContent?.createTime)
                .fontSize(10)
                .fontColor($r('app.color.third_text'))
            }
          }
          .height(30)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
        }
        .justifyContent(FlexAlign.Start)
        .width(FULL_PERCENT)

        DawsilingContent({ moyuContent: this.moyuContent, content: this.content, maxLine: 3 })


        Divider()

        Row() {
          Row({ space: 5 }) {
            Image($r('app.media.ic_public_thumbsup')).width(15).height(15)
            Text(`${this.moyuContent?.thumbUpCount}`)
              .fontSize(13)
          }.layoutWeight(1)
          .justifyContent(FlexAlign.Center)

          Divider()
            .vertical(true)

          Row({ space: 5 }) {
            Image($r('app.media.ic_public_comments')).width(15).height(15)
            Text(`${this.moyuContent?.commentCount}`)
              .fontSize(13)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)

          Divider()
            .vertical(true)

          Row({ space: 5 }) {
            Image($r('app.media.ic_public_share')).width(15).height(15)
            Text("分享")
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
      .borderRadius(5)
      .onClick(() => {
        this.navPathStack.replacePath({
          name: Dawdiling,
          param: { moyuContent: this.moyuContent, content: this.content } as DawdilingDetailData
        })
      })

    }
  }
}