import { moyu, user } from '../../api'
import { router } from '@kit.ArkUI'
import { RouterParams } from '../../view_model'
import { TitleBar } from '../../component/TitleBar'
import { FULL_PERCENT } from '../../constants'

@Entry
@Component
struct UserPage {
  uid: string | undefined = (router.getParams() as RouterParams).uid
  @State userInfo: user.UserInfo | undefined = undefined
  @State moment: moyu.Moment[] = []
  @State achievement: user.Achievement | undefined = undefined

  async aboutToAppear(): Promise<void> {
    this.userInfo = await user.user_info(this.uid)
    this.moment = await moyu.moyuList_user(this.uid, 1)
    this.achievement = await user.achievement(this.uid)
  }

  build() {
    Column() {
      TitleBar()
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

          }
          .height(FULL_PERCENT)
        }
      }
      .height(FULL_PERCENT)
    }
    .padding({ right: 20, left: 20 })

  }
}