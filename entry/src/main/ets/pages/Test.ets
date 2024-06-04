import { Document, parseDocument } from '@ohos/htmlparser2';
import { RichHtml } from '../component/RichHtml';


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
<p><b><i>正文</i></b><a href="aaa">链接</a></p>
<hr>
<blockquote>
    <p>引用</p>
    <h1>一级标题</h1>
</blockquote>
<pre><code>
代码块
</code></pre>
<img src="https://statics.moonshot.cn/kimi-chat/static/01.0245bc9d.png">
<ol>
	<li>27446大面额折扣</li>
	<li>31362天天特卖</li>
	<li>84229天猫超市</li>
	<li>13367女装</li>
	<li>13370鞋包配饰</li>
	<li>13371美妆护理</li>
	<li>13369数码家电</li>
	<li>78393宠物</li>
	<li>13372男装</li>
	<li>13373内衣</li>
	<li>13376运动户外</li>
	<li>13374母婴</li>
	<li>13371美妆护理</li>
	<li>13369数码家电</li>
	<li>78393宠物</li>
	<li>13372男装</li>
	<li>13373内衣</li>
	<li>13376运动户外</li>
	<li>13374母婴</li>
</ol>
`;
  @State dom: Document | null = null

  aboutToAppear(): void {
    this.dom = parseDocument(this.message)
  }

  build() {
    Scroll() {
      RichHtml({content: this.message})
    }
    .height("100%")
  }
}