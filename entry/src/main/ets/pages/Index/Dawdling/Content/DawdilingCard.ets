import { HPRichText, RichTextOption } from '@ohasasugar/hp-richtext'
import { moyu } from '../../../../api'
import { FULL_PERCENT } from '../../../../constants'
import { router, window } from '@kit.ArkUI'
import { RouterParams } from '../../../../view_model'

@Component
@Preview
export struct DawdlingCard {
  @Prop moyuContent: moyu.MoyuContent | null = null
  @State richTextOption: RichTextOption | null = null
  @State showMore: boolean = false;
  @State textHeight: number = 199

  aboutToAppear(): void {
    this.richTextOption = {
      content: this.moyuContent?.content as string,
      imageProp: {
        webp: true
      },
      baseFontSize: 12
    }
  }

  build() {
    // todo 点击进入详情页
    Column({ space: 10 }) {
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

      HPRichText({ richTextOption: $richTextOption })
        .width(FULL_PERCENT)
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.moyuContent?.images, (item: string, index: number) => {
          Image(item)
            .sharedTransition(item)
            .height(100)
            .width(100)
            .margin({ right: 10 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ImagePreview/ImagePreview',
                params: {
                  imageUrls: this.moyuContent?.images,
                  imageIndex: index,
                  shareID: item
                }
              })
            })
            .autoResize(true)
        })
      }

      if (this.moyuContent?.linkUrl) {
        Row({ space: 5 }) {

          if (this.moyuContent?.linkCover) {
            Image(this.moyuContent?.linkCover)
              .width(70)
              .height(70)
          }
          Column({ space: 5 }) {
            if (this.moyuContent.linkTitle) {
              Text(this.moyuContent.linkTitle)
                .fontSize(14)
                .textOverflow({
                  overflow: TextOverflow.Ellipsis
                })
                .maxLines(1)
            }
            Text(this.moyuContent.linkUrl).fontSize(12)
              .fontColor($r('app.color.hyper_link'))
              .textOverflow({
                overflow: TextOverflow.Ellipsis
              })
              .maxLines(1)
          }
          .alignItems(HorizontalAlign.Start)

        }
        .justifyContent(FlexAlign.Start)
        .padding(10)
        .border({
          width: 0.5,
          color: $r('app.color.divider')
        })
        .borderRadius(5)
        .height(70)
        .width("95%")
        .alignSelf(ItemAlign.Center)
      }
      if (this.moyuContent?.topicName) {
        Text(this.moyuContent.topicName)
          .padding({
            top: 5, bottom: 5,
            right: 10, left: 10
          })
          .fontSize(10)
          .fontColor($r('app.color.hyper_link'))
          .backgroundColor($r('app.color.hyper_link_back'))
          .borderRadius(5)
      }

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
  }
}