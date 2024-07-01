import { moyu } from '../../../../api'
import { router } from '@kit.ArkUI'
import { FULL_PERCENT } from '../../../../constants'

@Component
export struct DawsilingContent {
  @Prop moyuContent: moyu.Moment
  @Prop content: string
  @Prop maxLine: number = -1
  build() {
    Column({space: 10}){
      if (this.content) {
        Text(this.content)
          .maxLines(this.maxLine)
          .fontSize(14)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      // 图片列表
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.moyuContent?.images, (item: string, index: number) => {
          Image(item)
            .alt($r('app.media.image_error'))
            .sharedTransition(JSON.stringify(item) + index)
            .height(80)
            .width(80)
            .margin({ right: 5, bottom: 5 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ImagePreview/ImagePreview',
                params: {
                  imageUrls: this.moyuContent?.images,
                  imageIndex: index,
                }
              })
            })
            .autoResize(true)
            .borderRadius(5)
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
    }
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
}