import { ListInfoModel, moyu, user } from '../../../../api'
import { DawsilingContent } from './DawdilingContent'
import { FULL_PERCENT } from '../../../../constants'
import { router, SegmentButtonOptions } from '@kit.ArkUI'
import { ItemRestriction, SegmentButton, SegmentButtonTextItem } from '@ohos.arkui.advanced.SegmentButton'
import { ListAdapter, UserAuthentication } from '../../../../utils'
import { CommentInput, NavDestinationHeader, PushAction, RefreshList } from '../../../../component'


export interface DawdilingDetailData {
  moment: moyu.MomentModel
  content: string
}

@Component
export struct DawdilingDetail {
  // 动态信息
  @State @Watch("refresh") private moment: moyu.MomentModel | undefined = undefined
  // 内容
  @State private content: string | undefined = undefined
  // 评论列表
  @State private comments: moyu.MoyuComment[] | undefined = undefined
  // tab选项
  @State private tabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttonPadding: 0,
    fontSize: 10,
    selectedFontSize: 11,
    buttons: [{ text: '评论' }, { text: '点赞' }] as ItemRestriction<SegmentButtonTextItem>,
    backgroundBlurStyle: BlurStyle.BACKGROUND_THICK
  })
  // 当前选择tab
  @State private tabSelectedIndexes: number[] = [0]
  // 评论列表适配器
  @State private commentAdapter: ListAdapter<moyu.MoyuComment> = new ListAdapter<moyu.MoyuComment>()
  // 点赞列表适配器
  @State private thumbUpAdapter: ListAdapter<string> | undefined = undefined
  // 是否有下一页
  @State private hasNext: boolean = false
  // 当前页
  @State private currentPage: number = 0
  // 评论总数
  @State private total: number = 0
  // 是否刷新中
  @State private refreshing: boolean = false
  // 是否显示评论输入框
  @State private isShowCommentInput: boolean = false
  // 当前评论对象
  @State private currentCommentName: string = ''
  // 当前评论提交事件
  @State private currentCommentAction: PushAction | undefined = undefined

  async refresh(){
    // 评论
    const commentList = await moyu.commentList(this.moment?.id as string)
    this.comments = commentList.list
    this.total = commentList.total
    this.hasNext = commentList.hasNext
    this.currentPage = commentList.currentPage
    this.commentAdapter.setData(this.comments as moyu.MoyuComment[])
    // 动态
    if (this.moment) {
      this.moment = await moyu.oneMoment(this.moment?.id)
    }
  }


  async loading() {
    if (this.hasNext) {
      const commentList: ListInfoModel<moyu.MoyuComment> = await moyu.commentList(this.moment?.id as string, this.currentPage + 1)
      this.comments?.push(...commentList.list)
      this.hasNext = commentList.hasNext
      this.currentPage = commentList.currentPage
      this.commentAdapter?.setData(this.comments as moyu.MoyuComment[])
    }
  }

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        NavDestinationHeader() {
          if (this.moment) {
            Image(this.moment?.avatar)
              .width(30)
              .height(30)
              .borderRadius(100)
              .alt($r('app.media.image_error'))
              .autoResize(true)
            Column({ space: 5 }) {
              Text(this.moment?.nickname).fontWeight(FontWeight.Bold)
                .fontSize(12)
                .fontColor(this.moment?.vip ? $r('app.color.vip') : $r('app.color.first_text'))
              Text(this.moment?.createTime)
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
          Scroll() {
            Column({ space: 10 }) {
              DawsilingContent({ moyuContent: this.moment, content: this.content })
                .width(FULL_PERCENT)
              Divider()
                .width(FULL_PERCENT)
              if (this.comments) {
                Column({ space: 10 }) {
                  Row() {
                    Text(`共 ${this.tabSelectedIndexes[0] === 0 ? this.total : this.moment?.thumbUpCount} 条${this.tabSelectedIndexes[0] === 0 ? "评论" : "点赞"}`)
                      .fontSize(12)
                      .fontWeight(FontWeight.Bold)
                    Blank()
                    SegmentButton({
                      options: this.tabOptions,
                      selectedIndexes: $tabSelectedIndexes
                    }).width(80).height(30)
                  }.width(FULL_PERCENT)

                  if (this.tabSelectedIndexes[0] === 0) {
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
                          this.commentItem(item as moyu.MoyuComment, index)
                        },
                        loading: async () => {
                          await this.loading()
                        }
                      })
                    }
                  }
                  else if (this.tabSelectedIndexes[0] === 1) {
                    if (this.thumbUpAdapter) {
                      RefreshList({
                        listAdapter: $thumbUpAdapter,
                        nestedScrollOptions: {
                          scrollForward: NestedScrollMode.PARENT_FIRST,
                          scrollBackward: NestedScrollMode.SELF_FIRST
                        },
                        bottomDistance: 100,
                        needRefresh: false,
                        itemView: (item, index) => {
                          this.thumbUpItem(item as string, index)
                        },
                      })
                    }
                  }
                }
                .height(FULL_PERCENT)
                .width(FULL_PERCENT)
              }
            }
          }
          .align(Alignment.Top)
          .width(FULL_PERCENT)
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .onRefreshing(async () => {
          await this.refresh()
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
              if (await UserAuthentication.isLogin()) {
                this.currentCommentName = this.moment!.nickname
                this.currentCommentAction = {
                  push: async (content: string) => {
                    if (this.moment) {
                      if (await moyu.comment(this.moment.id, content)) {
                        this.isShowCommentInput = false
                        this.refreshing = true
                      }
                    }
                  }
                } as PushAction
                this.isShowCommentInput = true
              } else {
                router.pushUrl({
                  url: 'pages/Login/Login'
                })
              }
            })

          Image(this.moment?.hasThumbUp ? $r('app.media.ic_public_thumbsup_filled') : $r('app.media.ic_public_thumbsup'))
            .height(20)
            .width(20)
            .onClick(async () => {
              if (this.moment) {
                if (await moyu.thumb_up(this.moment.id)) {
                  this.moment.hasThumbUp = true
                }
              }
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
      .bindSheet($$this.isShowCommentInput, this.commentInput(), {
        height: SheetSize.FIT_CONTENT,
        showClose: false
      })

    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      const data: DawdilingDetailData = ctx.pathInfo.param as DawdilingDetailData
      this.moment = data.moment
      this.content = data.content
      this.thumbUpAdapter = new ListAdapter<string>(this.moment.thumbUpList)
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

  @Builder
  commentItem(item: moyu.MoyuComment, index: number) {
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
        Text(item.content).fontSize(13)
        Text(item.createTime)
          .fontSize(10)
          .fontColor($r('app.color.second_text'))
          .margin({ top: 5 })
        if (item.subComments.length) {
          Column({ space: 5 }) {
            ForEach((item as moyu.MoyuComment).subComments, (subItem: moyu.SubComment, index: number) => {
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
          push: async (content: string) => {
            if (await moyu.sub_comment({
              content,
              momentId: this.moment?.id,
              targetUserId: item.userId,
              commentId: item.id,
            } as moyu.SubCommentParam)) {
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
  subCommentItem(subItem: moyu.SubComment, index: number) {

    Text() {
      Span(subItem.nickname).fontColor($r('app.color.selected_background_for_component'))
      Span(" 回复 ")
      Span(subItem.targetUserNickname).fontColor($r('app.color.selected_background_for_component'))
      Span(": ")
      Span(subItem.content)
    }
    .fontSize(12)
    .width(FULL_PERCENT)
    .onClick(async () => {
      if (await UserAuthentication.isLogin()) {
        this.currentCommentName = subItem.nickname
        this.currentCommentAction = {
          push: async (content: string) => {
            if (await moyu.sub_comment({
              content,
              momentId: this.moment?.id,
              targetUserId: subItem.userId,
              commentId: subItem.id,
            } as moyu.SubCommentParam)) {
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
  thumbUpItem(item: string, index: number) {
    ThumbUpItem({ item: item as string, index: index })
  }
}

@Component
struct ThumbUpItem {
  @Require @Prop item: string
  @Require @Prop index: number
  @State private userInfo: user.UserInfo | undefined = undefined

  async aboutToAppear(): Promise<void> {
    this.userInfo = await user.user_info(this.item)
  }

  build() {
    if (this.userInfo) {
      Row({ space: 5 }) {
        Image(this.userInfo?.avatar)
          .width(25)
          .height(25)
          .borderRadius(100)
          .autoResize(true)
          .alt($r('app.media.image_error'))
        // Column({ space: 2 }) {
        Text(this.userInfo?.nickname).fontWeight(FontWeight.Bold)
          .fontColor(this.userInfo?.vip ? $r('app.color.vip') : $r('app.color.second_text'))
          .fontSize(12)
        Text(this.userInfo?.position ? this.userInfo?.position : "游民")
          .fontSize(10)
          .fontColor($r('app.color.third_text'))
        Text(this.userInfo?.company ? this.userInfo?.company : "无业")
          .fontSize(10)
          .fontColor($r('app.color.third_text'))
      }
      .justifyContent(FlexAlign.Start)
      .width(FULL_PERCENT)
    }
  }
}
