import { content } from '../../../../api'
import { CommentInput, NavDestinationHeader, PushAction, RefreshList } from '../../../../component'
import { FULL_PERCENT } from '../../../../constants'
import { ListAdapter, UserAuthentication } from '../../../../utils'
import { router } from '@kit.ArkUI'
import { webview } from '@kit.ArkWeb'

@Component
export struct ArticleDetail {
  @State @Watch('loadContent') private ctContent: content.CtContent | undefined = undefined
  @State private articleDetail: content.ArticleDetail | undefined = undefined
  @State private refreshing: boolean = false
  @State private currentPage: number = 1
  @State private hasNext: boolean = false
  @State private commentAdapter: ListAdapter<content.Content> = new ListAdapter()
  @State private isShowCommentInput: boolean = false
  // 当前评论对象
  @State private currentCommentName: string = ''
  // 当前评论提交事件
  @State private currentCommentAction: PushAction | undefined = undefined
  scroll: Scroller = new Scroller()
  controller: WebviewController = new webview.WebviewController()

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
    } else {
      this.hasNext = false
    }
  }

  build() {
    NavDestination() {
      Column() {
        NavDestinationHeader() {
          Row({ space: 10 }) {
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
          }.layoutWeight(1)
          .gesture(
            TapGesture({ count: 2, fingers: 1 }).onAction(() => {
              this.scroll.scrollEdge(Edge.Top)
            })
          )
        }

        Refresh({ refreshing: $$this.refreshing }) {
          Scroll(this.scroll) {
            Column({ space: 10 }) {
              // Image(this.articleDetail?.covers[0]).width(FULL_PERCENT).height(150)
              //   .borderRadius(5)
              // BiuMarkdown({ content: new HmdConv().html2md(this.articleDetail?.content) })

              // todo 提取文章显示
              if (this.articleDetail){
                Web({
                  controller: this.controller,
                  src: $rawfile("markdown-preview.html"),
                })
                  .onPageEnd(() => {
                    this.controller.runJavaScript(`addContent("${this.articleDetail?.content}")`)
                  })
                  .nestedScroll({
                    scrollForward: NestedScrollMode.SELF_FIRST,
                    scrollBackward: NestedScrollMode.PARENT_FIRST
                  })
                  .height("100%")


              }


              Flex() {
                ForEach(this.articleDetail?.labels, (item: string, index: number) => {
                  Text(item)
                    .padding(5)
                    .margin(3)
                    .fontSize(12)
                    .fontColor($r('app.color.second_text'))
                    .backgroundColor("#ecf5ff")
                })
              }

              Column({ space: 10 }) {
                if (this.commentAdapter) {
                  Divider()
                  Row() {
                    Text(`共 ${this.commentAdapter.totalCount()} 条评论`)
                      .fontSize(12)
                      .fontWeight(FontWeight.Bold)
                  }
                  .justifyContent(FlexAlign.Start)
                  .width(FULL_PERCENT)
                  .padding({ top: 10, bottom: 10 })

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

        if (this.articleDetail) {
          Row({ space: 15 }) {
            Text($r('app.string.write_comments'))
              .fontColor($r('app.color.second_text'))
              .fontSize(14)
              .borderRadius(100)
              .padding({ left: 15, right: 15, top: 10, bottom: 10 })
              .layoutWeight(1)
              .backgroundColor($r('app.color.list_back'))
              .onClick(async () => {
                if (await UserAuthentication.isLogin()) {
                  this.currentCommentName = this.articleDetail!.nickname
                  this.currentCommentAction = {
                    push: async (value: string) => {
                      if (await content.comment(this.articleDetail!.id, value)) {
                        this.isShowCommentInput = false
                        this.refreshing = true
                      }
                    }
                  } as PushAction
                  this.isShowCommentInput = true
                }
                else {
                  router.pushUrl({
                    url: 'pages/Login/Login'
                  })
                }
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
      }
      .padding({ left: 20, right: 20 })
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
      .justifyContent(FlexAlign.Start)
      .bindSheet($$this.isShowCommentInput, this.commentInput(), {
        height: SheetSize.FIT_CONTENT,
        showClose: false
      })
    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      this.ctContent = ctx.pathInfo.param as content.CtContent
    })
  }

  @Builder
  commentItem(item: content.Content, _index: number) {

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
      if (await UserAuthentication.isLogin()) {
        this.currentCommentName = item.nickname
        this.currentCommentAction = {
          push: async (value: string) => {
            if (await content.sub_comment(this.articleDetail!.id,
              item._id,
              item.userId,
              item.nickname,
              value)) {
              this.isShowCommentInput = false
              this.refreshing = true
            }
          }
        } as PushAction
        this.isShowCommentInput = true
      }
      else {
        router.pushUrl({
          url: 'pages/Login/Login'
        })
      }
    })

  }

  @Builder
  subCommentItem(subItem: content.SubComment, _index: number) {

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
      if (await UserAuthentication.isLogin()) {
        this.currentCommentName = subItem.yourNickname
        this.currentCommentAction = {
          push: async (value: string) => {
            if (await content.sub_comment(this.articleDetail!.id,
              subItem._id,
              subItem.yourUid,
              subItem.yourNickname,
              value)) {
              this.isShowCommentInput = false
              this.refreshing = true
            }
          }
        } as PushAction
        this.isShowCommentInput = true
      }
      else {
        router.pushUrl({
          url: 'pages/Login/Login'
        })
      }
    })
  }

  @Builder
  commentInput() {
    Column() {
      CommentInput({
        name: this.currentCommentName,
        pushAction: this.currentCommentAction,
      })
    }
  }
}