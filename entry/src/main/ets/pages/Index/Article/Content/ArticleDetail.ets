import { content } from '../../../../api'
import { NavDestinationHeader } from '../../../../component'
import { FULL_PERCENT } from '../../../../constants'

@Component
export struct ArticleDetail {
  @State @Watch('loadContent') ctContent: content.CtContent | undefined = undefined
  @State articleDetail: content.ArticleDetail | undefined = undefined
  @State refreshing: boolean = false


  async loadContent(){

  }

  build() {
    NavDestination() {
      Column() {
        NavDestinationHeader() {
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
        }
        Refresh({refreshing: $$this.refreshing}){
          Scroll(){
            Column({ space: 10 }){
              Image(this.articleDetail?.covers[0]).width(FULL_PERCENT).height(150)
              // todo 完善文章详情页

            }
          }
          .align(Alignment.Top)
          .width(FULL_PERCENT)
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }.layoutWeight(1)
      }
      .padding({ left: 20, right: 20 })
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
      .justifyContent(FlexAlign.Start)
    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      this.ctContent = ctx.pathInfo.param as content.CtContent
    })
  }
}