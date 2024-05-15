import { user } from '../../api'
import { TitleBar } from '../../component'
import { FULL_PERCENT, phoneRegex } from '../../constants'
import { image } from '@kit.ImageKit'
import { router } from '@kit.ArkUI'
import { UserAuthentication } from '../../utils'

@Entry
@Component
struct Login {

  @State captcha: user.Captcha | undefined = undefined
  @State captchaImage: image.PixelMap | undefined = undefined
  @State avatar: string = ''
  @State phoneNum: string = ''
  @State password: string = ''
  @State captchaText: string = ''

  async aboutToAppear(): Promise<void> {
    this.loadCaptcha()
  }

  async loadCaptcha() {
    this.captcha = await user.captcha()
    this.captchaImage = await image.createImageSource(this.captcha.image).createPixelMap()
  }

  async login(){
    if (await user.login(this.phoneNum,this.password,this.captchaText,this.captcha?.l_c_i)) {
      if (await user.checkToken()) {
        await UserAuthentication.initUserInfo()
        router.back()
      }
    }else{
      this.loadCaptcha()
    }
  }

  build() {
    Column({
      space: 30
    }) {
      TitleBar(){
        Text($r('app.string.login'))
      }
      Text($r('app.string.sob_user_login'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Image(this.avatar).width(100).height(100)
        .borderRadius(100)
        .alt($r('app.media.fingerprint'))


      Column({space: 10}){
        TextInput({ text: $$this.phoneNum ,placeholder: $r('app.string.input_phone') })
          .fontSize(20)
          .height(50)
          .type(InputType.PhoneNumber)
          .onChange(async (value: string) => {
            if (phoneRegex.test(value)) {
              this.avatar = await user.avatar(value)
            }
          })
        TextInput({ text: $$this.password, placeholder: $r('app.string.input_password') })
          .fontSize(20)
          .height(50)
          .type(InputType.Password)

        Row({space: 10}){
          TextInput({ text: $$this.captchaText,placeholder: $r('app.string.input_verification_code') })
            .fontSize(20)
            .height(50)
            .layoutWeight(1)
          Image(this.captchaImage).height(50)
            .onClick(() => {
              this.loadCaptcha()
            })
        }
        .width(FULL_PERCENT)

        Button($r('app.string.login'))
          .width(FULL_PERCENT)
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(async () => {
            await this.login()
          })

        Row({space: 20}){
          Text($r('app.string.forgot_password'))
            .fontColor($r('app.color.selected_background_for_component'))
          Column()
            .backgroundColor('#000')
            .width(1)
            .height(20)
          Text($r('app.string.register'))
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