import { FULL_PERCENT } from '../../../constants'

@Component
export struct User {
  build() {
    Column(){

      Row({space: 8}){
        Image("")
          .alt($r("app.media.fingerprint"))
          .width(75)
          .height(75)
        Column({space: 3}){
          Text("名字")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text("签名签名签名签名签名签名签名签名签名")
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .fontSize(14)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)


      }
      .padding(10)
      .width(FULL_PERCENT)

      Column({space: 10}){
        Text("message")
          .margin(10)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)

        Text("消息")
        Divider()
        Text("消息")
        Divider()
        Text("消息")
        Divider()
        Text("消息")
        Divider()
        Text("消息")
        Divider()
      }.padding(10)
      .width("100%")
      .backgroundColor($r("app.color.start_window_background"))
      .borderRadius(10)


    }
    .padding(10)
    .backgroundColor($r('app.color.list_back'))
    .width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }
}