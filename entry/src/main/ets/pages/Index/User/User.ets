import { user } from '../../../api'
import { NavFollow, FULL_PERCENT } from '../../../constants'
import { router } from '@kit.ArkUI'
import { RouterParams } from '../../../view_model'

@Component
export struct User {
  @StorageLink("userInfo") userInfo: user.UserInfo | null = null
  @Consume navPathStack: NavPathStack

  build() {
    Scroll() {
      Column() {

        Row() {
          Image($r("app.media.ic_public_settings"))
            .width(30)
            .height(30)
        }
        .padding(10)
        .width("100%")
        .justifyContent(FlexAlign.End)

        Row({ space: 10 }) {
          Image(this.userInfo ? this.userInfo.avatar : null)
            .alt($r("app.media.fingerprint"))
            .width(75)
            .height(75)
            .borderRadius(75)
          Column({ space: 10 }) {
            Row({ space: 8 }) {
              Text(this.userInfo ? this.userInfo.nickname : "未登录")
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              if (this.userInfo?.vip) {
                Text("vip")
                  .fontColor(Color.White)
                  .padding({ left: 5, right: 5, top: 2, bottom: 2 })
                  .backgroundColor($r('app.color.vip'))
                  .fontWeight(FontWeight.Bold)
                  .borderRadius(5)
              }
            }

            if (this.userInfo) {
              Text(this.userInfo.sign || "无签名")
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .fontSize(14)
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Image($r('sys.media.ohos_ic_back'))
            .width(25)
            .height(25)
            .rotate({
              angle: 180
            })

        }
        .padding(15)
        .width(FULL_PERCENT)
        .onClick(() => {
          if (!this.userInfo) {
            router.pushUrl({
              url: 'pages/Login/Login'
            })
          }
          else {
            if (this.userInfo) {
              router.pushUrl({
                url: 'pages/User/UserPage',
                params: {uid: this.userInfo.userId} as RouterParams
              })
            }
          }
        })

        if (this.userInfo) {
          Column({ space: 30 }) {
            Row({ space: 10 }) {
              Image($r("app.media.ic_public_highlight"))
                .width(20)
                .height(20)
              Text("我的关注")
            }
            .width(FULL_PERCENT)
            .onClick(() => {
              this.navPathStack.replacePath({ name: NavFollow })
            })

            Row({ space: 10 }) {
              Image($r("app.media.ic_contacts_assistant"))
                .width(20)
                .height(20)
              Text("我的粉丝")
            }
            .width(FULL_PERCENT)

            Row({ space: 10 }) {
              Image($r("app.media.ic_public_community_messages"))
                .width(20)
                .height(20)
              Text("消息中心")
            }
            .width(FULL_PERCENT)

            Row({ space: 10 }) {
              Image($r("app.media.ic_public_edit"))
                .width(20)
                .height(20)
              Text("我的文章")
            }
            .width(FULL_PERCENT)

            Row({ space: 10 }) {
              Image($r("app.media.ic_public_favor"))
                .width(20)
                .height(20)
              Text("我的收藏")
            }
            .width(FULL_PERCENT)

          }
          .alignItems(HorizontalAlign.Start)
          .padding(15)
          .width("100%")
          .backgroundColor($r("app.color.start_window_background"))
          .borderRadius(10)
        }

      }
      .padding(10)
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
    }
    .width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }
}