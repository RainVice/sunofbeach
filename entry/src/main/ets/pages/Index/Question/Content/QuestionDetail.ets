import { wenda } from '../../../../api'
import { NavDestinationHeader } from '../../../../component/NavDestinationHeader'
import { FULL_PERCENT } from '../../../../constants'
import { RefreshList } from '../../../../component/RefreshList';
import { ListAdapter } from '../../../../utils';
import { RichHtml } from '../../../../component';


@Component
export struct QuestionDetail {
  @State @Watch("refresh") content: wenda.WenDaList | null = null
  @State wenDaDetail: wenda.WenDaDetail | null = null
  @State comment_list: wenda.WendaComment[] = []
  @State private refreshing: boolean = false
  @State private listAdapter: ListAdapter<wenda.WendaComment> = new ListAdapter<wenda.WendaComment>()
  @State hasNext: boolean = true
  @State currentPage: number = 1;

  async refresh() {
    this.wenDaDetail = await wenda.wenda_detail(this.content?.id)
    this.comment_list = await wenda.comment_list(this.content?.id, 1)
    this.listAdapter.setData(this.comment_list)
  }

  async load(){
    const list = await wenda.comment_list(this.content?.id, this.currentPage+1)
    this.hasNext = list.length > 0
    if (list.length > 0) {
      this.currentPage++
    }
    this.comment_list.push(...list)
    this.listAdapter.addData(...list)
  }

  build() {
    NavDestination() {
      if (this.content) {
        Column() {
          Row() {
            NavDestinationHeader() {
              Text(this.content.title)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .fontSize(13)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.first_text'))
                .width("50%")
            }
          }
          .padding({ left: 20, right: 20 })

          Refresh({ refreshing: $$this.refreshing }) {
            Scroll() {
              Column({ space: 10 }) {
                if (this.wenDaDetail) {
                  Column({ space: 10 }) {

                    Row({ space: 10 }) {
                      Image(this.content?.avatar)
                        .width(30)
                        .height(30)
                        .borderRadius(100)
                        .autoResize(true)
                        .alt($r('app.media.image_error'))
                      Column({ space: 2 }) {
                        Text(this.content?.nickname).fontWeight(FontWeight.Bold)
                          .fontColor(this.content?.isVip === "1" ? $r('app.color.vip') : $r('app.color.second_text'))
                          .fontSize(14)
                        Text(this.content?.createTime)
                          .fontSize(10)
                          .fontColor($r('app.color.third_text'))

                      }
                      .height(30)
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.Center)

                      Blank()
                      if (this.content.isResolve === "1") {
                        Text("已解决").fontSize(13).fontColor($r('app.color.auxiliary')).fontWeight(FontWeight.Bold)
                      } else {
                        Text("未解决").fontSize(13).fontColor($r('app.color.second_text')).fontWeight(FontWeight.Bold)
                      }
                    }
                    .width(FULL_PERCENT)

                    Text(this.content.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .width(FULL_PERCENT)

                    // HPRichText({ richTextOption: $richTextOption })
                    //   .width(FULL_PERCENT)
                    RichHtml({content: this.wenDaDetail.description})
                  }
                  .width(FULL_PERCENT)
                  .padding(10)
                  .borderRadius(10)
                  .backgroundColor($r('app.color.start_window_background'))
                }

                Divider()

                if (this.comment_list) {
                  RefreshList({
                    listAdapter: $listAdapter,
                    hasNext: this.hasNext,
                    nestedScrollOptions: {
                      scrollForward: NestedScrollMode.PARENT_FIRST,
                      scrollBackward: NestedScrollMode.SELF_FIRST
                    },
                    topDistance: 0,
                    needRefresh: false,
                    itemView: (item, index) => {
                      this.commentItem(item as wenda.WendaComment, index)
                    },
                    loading: async () => {
                      await this.load()
                    }
                  })
                }
              }
              .width(FULL_PERCENT)
            }
            .width(FULL_PERCENT)
            .layoutWeight(1)
            .scrollBar(BarState.Off)
          }
          .onRefreshing(async ()=>{
            await this.refresh()
            this.refreshing = false
          })
          .backgroundColor($r('app.color.list_back'))
          .padding(10)
          .layoutWeight(1)
        }
        .width(FULL_PERCENT)
        .height(FULL_PERCENT)
        .justifyContent(FlexAlign.Start)
      }
    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      this.content = ctx.pathInfo.param as wenda.WenDaList
    })
  }

  @Builder
  commentItem(comment: wenda.WendaComment, index: number) {
    CommentItem({
      comment: comment,
      index: index
    })
  }
}

@Component
struct CommentItem {
  @Prop comment: wenda.WendaComment
  @Prop index: number


  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        Image(this.comment.avatar).height(30).width(30).autoResize(true).borderRadius(100)
        Column({ space: 2 }) {
          // 昵称
          Text(this.comment.nickname).fontWeight(FontWeight.Bold)
            .fontColor(this.comment?.isVip ? $r('app.color.vip') : $r('app.color.second_text'))
            .fontSize(14)
          // 时间
          Text(this.comment.publishTime).fontSize(13).fontColor($r('app.color.second_text'))

        }.alignItems(HorizontalAlign.Start)
      }.width(FULL_PERCENT)
      .justifyContent(FlexAlign.Start)

      // HPRichText({ richTextOption: $richTextOption })
      RichHtml({content: this.comment.content})
      Column({space: 2}) {
        ForEach(this.comment.wendaSubComments, (item: wenda.WendaSubComment) => {
          this.subComment(item)
        })
      }.backgroundColor($r('app.color.list_back'))
      .margin(5)
      .padding(5)
      .borderRadius(5)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
    .padding(10)
    .borderRadius(10)
    .backgroundColor($r('app.color.start_window_background'))
  }

  @Builder
  subComment(subItem: wenda.WendaSubComment) {
    Text() {
      Span(subItem.yourNickname).fontColor($r('app.color.selected_background_for_component'))
      Span(" 回复 ")
      Span(subItem.beNickname).fontColor($r('app.color.selected_background_for_component'))
      Span(": ")
      Span(subItem.content)
    }
    .fontSize(12)
    .width(FULL_PERCENT)
  }
}