import { content } from '../../../../api'
import { NavDestinationHeader, RefreshList } from '../../../../component'
import { FULL_PERCENT } from '../../../../constants'
import { BiuMarkdown } from '@hcs/biu-markdown'
import { HmdConv } from '@rv/hmd-conv/Index'
import { ListAdapter } from '../../../../utils'

@Component
export struct ArticleDetail {
  @State @Watch('loadContent') ctContent: content.CtContent | undefined = undefined
  @State articleDetail: content.ArticleDetail | undefined = undefined
  @State refreshing: boolean = false
  @State currentPage: number = 1
  @State hasNext: boolean = false
  @State commentAdapter: ListAdapter<content.Content> = new ListAdapter()

  scroll: Scroller = new Scroller()

  async loadContent() {
    this.currentPage = 1
    this.articleDetail = await content.article_detail(this.ctContent?.id as string)
    const comment = await content.article_comment(this.articleDetail.id, this.currentPage)
    this.commentAdapter.setData(comment.content)
    if (comment.total > 30) {
      this.hasNext = true
    }
  }

  async loading() {
    this.currentPage++
    const comment = await content.article_comment(this.articleDetail!.id, this.currentPage)
    this.commentAdapter.addData(...comment.content)
    if (comment.total > this.currentPage * 30) {
      this.hasNext = true
    }else{
      this.hasNext = false
    }
  }

  build() {
    NavDestination() {
      Column() {
        NavDestinationHeader() {
          if (this.ctContent) {
            Image(this.ctContent?.avatar)
              .width(30)
              .height(30)
              .borderRadius(100)
              .alt($r('app.media.image_error'))
              .autoResize(true)
            Column({ space: 5 }) {
              Text(this.ctContent?.nickName).fontWeight(FontWeight.Bold)
                .fontSize(12)
                .fontColor(this.ctContent?.vip ? $r('app.color.vip') : $r('app.color.first_text'))
              Text(this.ctContent?.createTime)
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
        }

        Refresh({ refreshing: $$this.refreshing }) {
          Scroll(this.scroll) {
            Column({ space: 10 }) {
              Image(this.articleDetail?.covers[0]).width(FULL_PERCENT).height(150)
              // todo 完善文章详情页
              BiuMarkdown({ content: new HmdConv().html2md(this.articleDetail?.content) })

              Column() {
                if (this.commentAdapter) {
                  RefreshList({
                    listAdapter: $commentAdapter,
                    hasNext: this.hasNext,
                    bottomDistance: 100,
                    nestedScrollOptions: {
                      scrollForward: NestedScrollMode.PARENT_FIRST,
                      scrollBackward: NestedScrollMode.SELF_FIRST
                    },
                    needRefresh: false,
                    itemView: (item, index) => {
                      this.commentItem(item as content.Content, index)
                    },
                    loading: async () => {

                    }
                  })
                }
              }
              .height(FULL_PERCENT)
              .width(FULL_PERCENT)

            }
          }
          .align(Alignment.Top)
          .width(FULL_PERCENT)
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }.layoutWeight(1)
        .onRefreshing(async () => {
          await this.loadContent()
          this.refreshing = false
        })
        .layoutWeight(1)

        Row({ space: 15 }) {
          Text("写评论")
            .fontColor($r('app.color.second_text'))
            .fontSize(14)
            .borderRadius(100)
            .padding({ left: 15, right: 15, top: 10, bottom: 10 })
            .layoutWeight(1)
            .backgroundColor($r('app.color.list_back'))
            .onClick(async () => {

            })
          Image($r('app.media.ic_public_comments')).height(20).width(20)
            .onClick(() => {
              this.scroll.scrollEdge(Edge.Bottom)
            })
          Image($r('app.media.ic_public_share')).height(20).width(20)

        }
        .padding(8)
        .height(50)
      }
      .padding({ left: 20, right: 20 })
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
      .justifyContent(FlexAlign.Start)
    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      this.ctContent = ctx.pathInfo.param as content.CtContent
    })
  }

  @Builder
  commentItem(item: content.Content, index: number) {

    Row({ space: 10 }) {
      Image(item.avatar)
        .width(30)
        .height(30)
        .borderRadius(100)
        .autoResize(true)
        .autoResize(true)
        .alt($r('app.media.image_error'))
      Column({ space: 5 }) {
        Text(item.nickname)
          .fontSize(14)
          .fontColor($r('app.color.selected_background_for_component'))
        Text(item.commentContent).fontSize(13)
        Text(item.publishTime)
          .fontSize(10)
          .fontColor($r('app.color.second_text'))
          .margin({ top: 5 })
        if (item.subComments.length) {
          Column({ space: 5 }) {
            ForEach(item.subComments, (subItem: content.SubComment, index: number) => {
              this.subCommentItem(subItem, index)
            })
          }
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
    .onClick(async () => {
      // 弹出回复框
    })

  }

  @Builder
  subCommentItem(subItem: content.SubComment, index: number) {

    Text() {
      Span(subItem.yourNickname).fontColor($r('app.color.selected_background_for_component'))
      Span(" 回复 ")
      Span(subItem.beNickname).fontColor($r('app.color.selected_background_for_component'))
      Span(": ")
      Span(subItem.content)
    }
    .fontSize(12)
    .width(FULL_PERCENT)
    .onClick(async () => {

    })

  }
}