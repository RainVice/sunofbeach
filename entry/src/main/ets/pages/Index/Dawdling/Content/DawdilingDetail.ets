import { ListInfo, moyu } from '../../../../api'
import { DawsilingContent } from './DawdilingContent'
import { FULL_PERCENT } from '../../../../constants'
import { SegmentButtonOptions } from '@kit.ArkUI'
import { ItemRestriction, SegmentButton, SegmentButtonTextItem } from '@ohos.arkui.advanced.SegmentButton'
import { ListAdapter } from '../../../../utils'


export interface DawdilingDetailData {
  moyuContent: moyu.MoyuContent
  content: string
}

@Component
export struct DawdilingDetail {
  @State @Watch("loadComment") private moyuContent: moyu.MoyuContent | undefined = undefined
  @State private content: string | undefined = undefined
  @State private comments: ListInfo<moyu.MoyuComment> | undefined = undefined
  @State private tabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttonPadding: 0,
    fontSize: 10,
    selectedFontSize: 11,
    buttons: [{ text: '评论' }, { text: '点赞' }] as ItemRestriction<SegmentButtonTextItem>,
    backgroundBlurStyle: BlurStyle.BACKGROUND_THICK
  })
  @State private tabSelectedIndexes: number[] = [0]
  @State private subCommentWidth: Length = 0
  @Consume navPathStack: NavPathStack
  private commentAdapter: ListAdapter<moyu.MoyuComment> | undefined = undefined

  async loadComment() {
    this.comments = await moyu.comment(this.moyuContent?.id as string)
    this.commentAdapter = new ListAdapter<moyu.MoyuComment>(this.comments?.list as moyu.MoyuComment[])
  }

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
              .fontColor($r('app.color.selected_background_for_component'))
              .padding({
                right: 10, left: 10,
                top: 5, bottom: 5
              })
              .borderRadius(100)
              .border({
                color: $r('app.color.selected_background_for_component'),
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
                .width(FULL_PERCENT)
              Divider()
                .width(FULL_PERCENT)
              if (this.comments) {
                Column({ space: 10 }) {
                  Row() {
                    Text(`共 ${this.comments.total} 条评论`).fontSize(12).fontWeight(FontWeight.Bold)
                    Blank()
                    SegmentButton({
                      options: this.tabOptions,
                      selectedIndexes: $tabSelectedIndexes
                    }).width(80).height(30)

                  }.width(FULL_PERCENT)

                  List({ space: 20 }) {
                    // todo 评论
                    if (this.commentAdapter) {
                      LazyForEach(this.commentAdapter, (item: moyu.MoyuComment, index: number) => {
                        ListItem() {
                          this.commentItem(item, index)
                        }.width(FULL_PERCENT)
                      })
                    }

                  }.width(FULL_PERCENT)
                }
                .height(FULL_PERCENT)
                .width(FULL_PERCENT)
              }
            }
          }
          .width(FULL_PERCENT)
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .padding({left: 20,right: 20})
        .width(FULL_PERCENT)
        .height(FULL_PERCENT)
        .justifyContent(FlexAlign.Start)
      }
    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      const data: DawdilingDetailData = ctx.pathInfo.param as DawdilingDetailData
      this.moyuContent = data.moyuContent
      this.content = data.content
    })
  }

  @Builder
  commentItem(item: moyu.MoyuComment, index: number) {
    Row({ space: 10 }) {
      Image(item.avatar).width(30).height(30).borderRadius(100).autoResize(true)
      Column({ space: 5 }) {
        Text(item.nickname).fontSize(14).fontColor($r('app.color.selected_background_for_component'))
        Text(item.content).fontSize(13)
        Text(item.createTime).fontSize(10).fontColor($r('app.color.second_text')).margin({ top: 5 })
        if (item.subComments) {
          Column() {
            ForEach(item.subComments, (subItem: moyu.SubComment, index: number) => {
              this.subCommentItem(subItem, index)
            })
          }
          .onAreaChange((oldVal: Area, newVal: Area) => {
            console.log(newVal.width.toString())
            this.subCommentWidth = newVal.width
          })
          .padding(10)
          .width(FULL_PERCENT)
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor($r('app.color.list_back'))
          .borderRadius(3)
        }
        else {
          Blank()
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  subCommentItem(subItem: moyu.SubComment, index: number) {

    Text() {
      Span(subItem.nickname).fontColor($r('app.color.selected_background_for_component'))
      Span("回复")
      Span(subItem.targetUserNickname).fontColor($r('app.color.selected_background_for_component'))
      Span(":")
      Span(subItem.content)
    }
    .fontSize(12)
    .width(FULL_PERCENT)

  }
}