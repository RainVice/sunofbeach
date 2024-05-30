import { webview } from '@kit.ArkWeb'

@Component
export struct MdPreview {
  @Require @Prop content: string
  @Link @Watch("refresh") refreshing: boolean
  controller: WebviewController = new webview.WebviewController()


  refresh(){
    if (this.refreshing) {
      this.controller.scrollTo(0,0)
    }
  }

  build() {
    Column() {
      Web({
        controller: this.controller,
        src: $rawfile("markdown-preview.html"),
      })
        .onPageEnd(async () => {
          await this.controller.runJavaScript(`addContent(\`${
          this.content.replace(/\$/g, '\\$')
            .replace(/{/g, '\\{')
            .replace(/}/g, '\\}')
            .replace(/`/g, '\\`')
          }\`)`)
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
