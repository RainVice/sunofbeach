import { user } from '../../api'
import { TitleBar } from '../../component'
import { FULL_PERCENT, phoneRegex } from '../../constants'
import { image } from '@kit.ImageKit'

@Entry
@Component
struct Login {

  @State captcha: user.Captcha | undefined = undefined
  @State captchaImage: image.PixelMap | undefined = undefined
  @State avatar: string = ''
  @State phoneNum: string = ''
  @State password: string = ''

  async aboutToAppear(): Promise<void> {
    this.captcha = await user.captcha()
    this.captchaImage = await image.createImageSource(this.captcha.image).createPixelMap()
  }

  build() {
    Column({
      space: 30
    }) {
      TitleBar(){
        Text("账号登录")
      }
      Text("阳光沙滩账号登录")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Image(this.avatar).width(100).height(100)
        .borderRadius(100)
        .alt($r('app.media.fingerprint'))


      Column({space: 10}){
        TextInput({ text: $$this.phoneNum ,placeholder: "输入手机号" })
          .fontSize(20)
          .height(50)
          .type(InputType.PhoneNumber)
          .onChange(async (value: string) => {
            if (phoneRegex.test(value)) {
              this.avatar = await user.avatar(value)
            }
          })
        TextInput({ text: $$this.password, placeholder: "输入密码" })
          .fontSize(20)
          .height(50)
          .type(InputType.Password)

        Row({space: 10}){
          TextInput({ placeholder: "输入图形验证码" })
            .fontSize(20)
            .height(50)
            .layoutWeight(1)
          Image(this.captchaImage).height(50)
        }
        .width(FULL_PERCENT)

        Button("登录")
          .width(FULL_PERCENT)
          .type(ButtonType.Normal)
          .borderRadius(8)

        Row({space: 20}){
          Text("忘记密码")
            .fontColor($r('app.color.selected_background_for_component'))
          Column()
            .backgroundColor('#000')
            .width(1)
            .height(20)
          Text("注册账户")
            .fontColor($r('app.color.selected_background_for_component'))
        }

      }
    }
    .padding({left: 20,right: 20})
    .justifyContent(FlexAlign.Start)
    .height(FULL_PERCENT)
    .width(FULL_PERCENT)

  }
}