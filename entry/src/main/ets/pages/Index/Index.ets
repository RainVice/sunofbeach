import { NavDawdiling, NavDawdilingTopicCategorize, FULL_PERCENT, NavArticle, NavQuestion,
  NavFollow,
  NavUserPage} from '../../constants'
import { IndexItem, indexItems } from '../../view_model'
import { Article } from './Article/Article'
import { Header } from './component/Header'
import { DawdilingDetail } from './Dawdling/Content/DawdilingDetail'
import { DawdilingAllTopic } from './Dawdling/Content/DawdilingAllTopic'
import { Dawdling } from './Dawdling/Dawdling'
import { Question } from './Question/Question'
import { User } from './User/User'
import { ArticleDetail } from './Article/Content/ArticleDetail'
import { QuestionDetail } from './Question/Content/QuestionDetail'
import { FollowList } from './User/Content/FollowList'
import { UserPage } from './User/UserPage'

@Entry
@Component
struct Index {
  @State toolBarIndex: number = 0
  @Provide navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column() {
      Navigation(this.navPathStack) {
        Tabs({ barPosition: BarPosition.End, index: $$this.toolBarIndex }) {
          ForEach(indexItems, (item: IndexItem, index: number) => {
            TabContent() {
              Scroll() {
                Column() {
                  // 首页摸鱼
                  if (index === 0) {
                    Header({
                      menuItem: [
                        {
                          image: $r('app.media.ic_public_community_messages'), action: () => {
                        }, description: $r('app.string.message')
                        },
                        {
                          image: $r('app.media.ic_public_add_filled'), action: () => {
                          // todo 发表动态
                        }, description: $r('app.string.add_article')
                        },
                        {
                          image: $r('app.media.ic_public_view_grid'), action: () => {
                          this.navPathStack.replacePath({ name: NavDawdilingTopicCategorize })
                        }, description: $r('app.string.more_topics')
                        },
                      ]
                    })
                    Dawdling()
                  }
                  else if (index === 1) {
                    Header({
                      menuItem: [
                        {
                          image: $r('app.media.ic_public_community_messages'), action: () => {
                        }, description: "消息"
                        },
                        {
                          image: $r('app.media.ic_public_add_filled'), action: () => {
                        }, description: "添加文章"
                        },
                        {
                          image: $r('app.media.ic_public_view_grid'), action: () => {
                        }, description: "更多话题"
                        },
                      ]
                    })
                    Article()
                  }
                  else if (index === 2) {
                    Header({
                      menuItem: [
                        {
                          image: $r('app.media.ic_public_community_messages'), action: () => {
                        }, description: "消息"
                        },
                        {
                          image: $r('app.media.ic_public_add_filled'), action: () => {
                        }, description: "提问"
                        },
                      ]
                    })
                    Question()
                  }
                  else if (index === 3) {
                    User()
                  }
                }
                .justifyContent(FlexAlign.Start)
              }
              .scrollBar(BarState.Off)
            }
            .tabBar(this.toolBar(index))
          })
        }
        .height(FULL_PERCENT)
        .width(FULL_PERCENT)
        .barOverlap(true)
        .barBackgroundBlurStyle(BlurStyle.Thin)
        .barBackgroundColor($r("app.color.background_color"))
      }
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
      .hideTitleBar(true)
      .navDestination(this.PageMap)
    }
    .width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }

  @Builder
  PageMap(name: string) {
    if (name === NavDawdiling) {
      DawdilingDetail()
    } else if (name === NavDawdilingTopicCategorize) {
      DawdilingAllTopic()
    } else if (name === NavArticle) {
      ArticleDetail()
    } else if (name === NavQuestion){
      QuestionDetail()
    }else if(name === NavFollow){
      FollowList()
    }else if (name === NavUserPage){
      UserPage()
    }
  }

  @Builder
  toolBar(index: number) {
    Row() {
      Column({ space: 2 }) {
        Image(indexItems[index].icon)
          .width(20)
          .height(20)
          .fillColor(index === this.toolBarIndex ? $r('app.color.selected_background_for_component') : $r('app.color.not_selected_background_for_component'))
        Text(indexItems[index].title)
          .fontSize(10)
          .fontColor($r('app.color.not_selected_background_for_component'))
      }
    }
  }
}