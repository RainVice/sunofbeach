import { content } from '../../../../api'
import { FULL_PERCENT } from '../../../../constants'

@Component
export struct ArticleDetail {
  // todo 完善文章详情页
  @State ctContent: content.CtContent | undefined = undefined
  build() {
    NavDestination() {

    }
    .hideTitleBar(true)
    .width(FULL_PERCENT)
    .onReady((ctx: NavDestinationContext) => {
      this.ctContent = ctx.pathInfo.param as content.CtContent
    })
  }
}