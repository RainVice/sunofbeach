import { Document, parseDocument } from '@ohos/htmlparser2';
import { RichHtmlBuilder } from '../component';

@Entry
@Component
struct Test {
  @State message: string = `
<h1>一级标题</h1>
<h2>二级标题</h2>
<h3>三级标题</h3>
<h4>四级标题</h4>
<h5>五级标题</h5>
<h6>六级标题</h6>
<p>正文</p>
<hr>
<blockquote>
    <p>引用</p>
    <h1>一级标题</h1>
</blockquote>
<pre><code>
123456
</code></pre>
`;
  @State dom: Document | null = null

  aboutToAppear(): void {
    this.dom = parseDocument(this.message)
  }

  build() {
    Column() {
      if (this.dom) {
        RichHtmlBuilder({ node: this.dom })
      }
    }
    .padding(10)
    .height("100%")
    .width('100%')
  }
}