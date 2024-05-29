import { webview } from '@kit.ArkWeb'

@Component
export struct MdPreview {
  @Require @Prop content: string
  @State webHeight: Length = "100%"
  controller: WebviewController = new webview.WebviewController()


  build() {
    Column() {
      Web({
        controller: this.controller,
        src: $rawfile("markdown-preview.html"),
      })
        .hitTestBehavior(HitTestMode.None)
        .javaScriptProxy({
          object: this,
          name: "MdPreviewEX",
          methodList: ["setHeight"],
          controller: this.controller
        })
        .domStorageAccess(true)
        .onPageEnd(async () => {
          await this.controller.runJavaScript(`addContent(\`${this.content}\`)`)
        })
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.PARENT_FIRST
        })
        .height(this.webHeight)
        .verticalScrollBarAccess(false)
    }
  }

  setHeight(height: number) {
    if (this.webHeight !== height) {
      this.webHeight = height
      this.controller.refresh()
    }
  }
}
