import { content, ListInfo, moyu, user, wenda } from '../../../api'
import { NavDestinationHeader, RefreshList } from '../../../component'
import { FULL_PERCENT } from '../../../constants'
import { ListAdapter } from '../../../utils'
import { contentCategorized, RouterParams } from '../../../view_model'
import { ArticleCard } from '../Article/Content/ArticleCard'
import { TabBar } from '../component/TabBar'
import { DawdlingCard } from '../Dawdling/Content/DawdilingCard'

@Component
export struct UserPage {
  @State @Watch("into") uid: string | undefined = undefined
  @State userInfo: user.UserInfo | undefined = undefined
  @State achievement: user.Achievement | undefined = undefined
  @State currentIndex: number = 0

  async into() {
    this.userInfo = await user.user_info(this.uid)
    this.achievement = await user.achievement(this.uid)
  }

  build() {
    NavDestination() {
      if (this.uid) {
        Column() {
          NavDestinationHeader()
          Scroll() {
            Column({ space: 10 }) {
              Column({ space: 10 }) {
                if (this.userInfo) {
                  Row() {
                    Image(this.userInfo.avatar)
                      .width(80)
                      .height(80)
                      .borderRadius(80)
                    Blank()
                    Text("编辑资料")
                      .fontWeight(FontWeight.Bold)
                      .padding({
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10
                      })
                      .borderRadius(100)
                      .backgroundColor("#ffeeeeee")

                  }.width(FULL_PERCENT)

                  Row() {
                    Text(this.userInfo.nickname)
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                    if (this.userInfo.vip) {
                      Text("vip")
                    }
                  }

                  if (this.achievement) {
                    Row({ space: 10 }) {
                      Text(`${this.achievement.thumbUpTotal} 获赞`)
                        .fontSize(18)
                        .fontWeight(FontWeight.Bold)
                      Text(`${this.achievement.fansCount} 粉丝`)
                        .fontSize(18)
                        .fontWeight(FontWeight.Bold)
                      Text(`${this.achievement.followCount} 关注`)
                        .fontSize(18)
                        .fontWeight(FontWeight.Bold)
                    }

                    Text(`写了${this.achievement.articleTotal}篇文章， ${this.achievement.shareTotal}篇分享，${this.achievement.momentCount}篇动态`)
                    Text(`获得点赞${this.achievement.thumbUpTotal}`)
                    Text(`回答了${this.achievement.thumbUpTotal}个问题，帮助他人解决了${this.achievement.resolveCount}个问题`)

                  }
                  if (this.userInfo.sign) {
                    Text() {
                      ImageSpan($r('sys.media.ohos_ic_public_edit'))
                        .width(20)
                        .height(20)
                      Span(this.userInfo.sign)
                    }
                  }
                  Flex() {
                    if (this.userInfo.company) {
                      Text(this.userInfo.company)
                    }
                    if (this.userInfo.position) {
                      Text(this.userInfo.position)
                    }
                  }
                }
              }
              // .backgroundColor("#80ffffff")
              .alignItems(HorizontalAlign.Start)

              Column() {
                Tabs({ index: $$this.currentIndex }) {
                  ForEach(contentCategorized, (item: string, index: number) => {
                    TabContent() {
                      if (index === 0) {
                        Moyu({ uid: this.uid })
                      } else if (index === 1) {
                        Article({ uid: this.uid })
                      } else if (index === 2) {
                        Answers({ uid: this.uid})
                      }
                    }
                    .align(Alignment.TopStart)
                    .tabBar(this.tabBar(item, index))
                  })
                }
              }
              .height(FULL_PERCENT)
            }
          }
          .scrollBar(BarState.Off)
          .height(FULL_PERCENT)
        }
        .padding({ right: 20, left: 20 })
      }
    }
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      this.uid = (ctx.pathInfo.param as RouterParams).uid
    })
    .hideTitleBar(true)
  }

  @Builder
  tabBar(name: string, index: number) {
    TabBar({
      currentIndex: this.currentIndex,
      name,
      index
    })
  }
}

@Component
struct Moyu {
  @Require @Prop uid: string
  @State adapter: ListAdapter<moyu.Moment> = new ListAdapter()
  @State hasNext: boolean = false
  @State currentPage: number = 1

  async refresh() {
    this.currentPage = 1
    const moyulist = await moyu.moyuList4user(this.uid, 1)
    if (moyulist.length < 30) {
      this.hasNext = false
    } else {
      this.hasNext = true
    }
    this.adapter.setData(moyulist)
  }

  async loading() {
    this.currentPage++
    const moyulist = await moyu.moyuList4user(this.uid, this.currentPage)
    if (moyulist.length < 30) {
      this.hasNext = false
    } else {
      this.hasNext = true
    }
    this.adapter.addData(...moyulist)
  }

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  build() {
    Column() {
      RefreshList({
        listAdapter: $adapter,
        hasNext: this.hasNext,
        itemView: this.listItem,
        nestedScrollOptions: {
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.PARENT_FIRST
        },
        refresh: async () => {
          await this.refresh()
        },
        loading: async () => {
          await this.loading()
        }
      })
    }

  }

  @Builder
  listItem(item: object | string | number | boolean, _index: number) {
    DawdlingCard({ moment: item as moyu.Moment })
  }
}


@Component
struct Article {
  @Require @Prop uid: string
  @State contents: ListInfo<content.CtContent> | undefined = undefined
  @State adapter: ListAdapter<content.CtContent> = new ListAdapter()

  async refresh() {
    this.contents = await content.article4user(this.uid, 1)
    this.adapter.setData(this.contents.list)
  }

  async loading() {
    this.contents = await content.article4user(this.uid, this.contents!.currentPage + 1)
    this.adapter.addData(...this.contents!.list)
  }

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  build() {
    Column() {
      RefreshList({
        listAdapter: $adapter,
        hasNext: this.contents?.hasNext,
        itemView: this.listItem,
        nestedScrollOptions: {
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.PARENT_FIRST
        },
        refresh: async () => {
          await this.refresh()
        },
        loading: async () => {
          await this.loading()
        }
      })
    }

  }

  @Builder
  listItem(item: object | string | number | boolean, _index: number) {
    ArticleCard({ ctContent: item as content.CtContent })
  }
}
@Component
struct Answers {
  @Require @Prop uid: string
  @State answers: wenda.Answer | undefined = undefined
  @State currentPage: number = 1
  @State adapter: ListAdapter<wenda.Content> = new ListAdapter()

  async refresh() {
    this.currentPage = 1
    this.answers = await wenda.wenda4user(this.uid, this.currentPage)
    this.adapter.setData(this.answers.content)
  }

  async loading() {
    this.answers = await wenda.wenda4user(this.uid, ++this.currentPage)
    this.adapter.addData(...this.answers.content)
  }

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  build() {
    Column() {
      RefreshList({
        listAdapter: $adapter,
        hasNext: !this.answers?.last,
        itemView: this.listItem,
        nestedScrollOptions: {
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.PARENT_FIRST
        },
        refresh: async () => {
          await this.refresh()
        },
        loading: async () => {
          await this.loading()
        }
      })
    }

  }

  @Builder
  listItem(item: object | string | number | boolean, _index: number) {
    Column(){
      Text((item as wenda.Content).wendaTitle)
        .fontWeight(FontWeight.Bold)
      Text((item as wenda.Content).wendaComment.publishTime)
        .fontSize(13)
        .fontColor($r('app.color.second_text'))
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .padding(15)
    .width(FULL_PERCENT)
  }
}