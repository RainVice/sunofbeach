import { webview } from '@kit.ArkWeb'

@Component
export struct MdPreview {

  @Require @Prop content: string
  controller: WebviewController = new webview.WebviewController()
  mdPreviewEX: MdPreviewEX = new MdPreviewEX()

  build() {
    Column(){
      Web({
        controller: this.controller,
        src: $rawfile("markdown-preview.html"),
      })
        .onConsole((event) => {
          // todo 获取高度
          return true
        })
        .javaScriptAccess(true)
        .onPageEnd(async () => {
          this.controller.registerJavaScriptProxy(this.mdPreviewEX,"MdPreviewEX",["setHeight"])
          this.controller.refresh()
          await this.controller.runJavaScript(`addContent("${this.content}")`)
        })
        .nestedScroll({
          scrollForward: NestedScrollMode.SELF_FIRST,
          scrollBackward: NestedScrollMode.PARENT_FIRST
        })
        .height("100%")
        .verticalScrollBarAccess(false)
    }
  }
}

class MdPreviewEX{
  setHeight(height:number){
    return
  }
}