import { moyu } from '../../../../api'
import { NavDawdiling, FULL_PERCENT } from '../../../../constants'
import { createDocumentStream, Document, DomUtils } from '@ohos/htmlparser2'
import { DawsilingContent } from './DawdilingContent'
import { DawdilingDetailData } from './DawdilingDetail'

@Component
export struct DawdlingCard {
  @Require @Prop moment: moyu.MomentModel
  @State content: string = ''
  @Consume navPathStack: NavPathStack

  aboutToAppear(): void {
    const parser = createDocumentStream((error: Error | null, dom: Document) => {
      this.content = DomUtils.textContent(dom)
    })
    parser.write(this.moment?.content as string)
    parser.end()
  }

  build() {
    if (this.moment) {
      Column({ space: 10 }) {
        // 头像
        Row({ space: 10 }) {
          Image(this.moment?.avatar).width(30).height(30).borderRadius(100)
            .autoResize(true)
            .alt($r('app.media.image_error'))
          Column({ space: 2 }) {
            Text(this.moment?.nickname).fontWeight(FontWeight.Bold)
              .fontColor(this.moment?.vip ? $r('app.color.vip') : $r('app.color.second_text'))
              .fontSize(14)
            Row({ space: 8 }) {
              Text(this.moment?.position ? this.moment?.position : $r('app.string.vagrant'))
                .fontSize(10)
                .fontColor($r('app.color.third_text'))
              Text(this.moment?.company ? this.moment?.company : $r('app.string.unemployed'))
                .fontSize(10)
                .fontColor($r('app.color.third_text'))
              Text(this.moment?.createTime)
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

        DawsilingContent({ moyuContent: this.moment, content: this.content, maxLine: 3 })


        Divider()

        Row() {
          Row({ space: 5 }) {
            Image($r('app.media.ic_public_thumbsup')).width(15).height(15)
            Text(`${this.moment?.thumbUpCount}`)
              .fontSize(13)
          }.layoutWeight(1)
          .justifyContent(FlexAlign.Center)

          Divider()
            .vertical(true)

          Row({ space: 5 }) {
            Image($r('app.media.ic_public_comments')).width(15).height(15)
            Text(`${this.moment?.commentCount}`)
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
        this.navPathStack.replacePath({
          name: NavDawdiling,
          param: { moment: this.moment, content: this.content } as DawdilingDetailData
        })
      })

    }
  }
}