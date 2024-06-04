import { Document, DomUtils, ElementType, parseDocument } from '@ohos/htmlparser2'
import { ChildNode, Element, hasChildren, isTag, isText, Text as DomText } from 'domhandler'

let num: number = 1

@Component
export struct RichHtml {
  @Require @Prop content: string
  @State private dom: Document | null = null

  aboutToAppear(): void {
    this.dom = parseDocument(this.content)
  }

  build() {
    Column({ space: 10 }) {
      if (this.dom && hasChildren(this.dom)) {
        ForEach(this.dom.childNodes, (item: ChildNode, index: number) => {
          if (isTag(item)) {
            root(item)
          }
        }, () => (num++).toString())
      }
    }
    .padding(10)
    .alignItems(HorizontalAlign.Start)
    .width("100%")
  }
}

@Builder
function root(node: Element) {
  header(node)
  paragraph(node)
  blockquote(node)
  list(node)
  blockCode(node)
  table(node)
  hr(node)
  img(node)
}

@Builder
function header(node: Element) {
  if (node.name === 'h1') {
    H1({ node: node })
  }
  else if (node.name === 'h2') {
    H2({ node: node })
  }
  else if (node.name === 'h3') {
    H3({ node: node })
  }
  else if (node.name === 'h4') {
    H4({ node: node })
  }
  else if (node.name === 'h5') {
    H5({ node: node })
  }
  else if (node.name === 'h6') {
    H6({ node: node })
  }
}

@Builder
function paragraph(node: Element) {
  if (node.name === 'p') {
    P({ node: node })
  }
}

@Builder
function blockquote(node: Element) {
  if (node.name === 'blockquote') {
    Blockquote({ node: node }) {
      if (hasChildren(node)) {
        ForEach(node.childNodes, (item: ChildNode, index: number) => {
          if (isTag(item)) {
            root(item)
          }
        }, () => (num++).toString())
      }
    }
  }
}

@Builder
function list(node: Element) {
  if (node.name === 'ul') {
    UnOrderList({ node: node })
  }
  else if (node.name === 'ol') {
    OrderList({ node: node })
  }
}

@Builder
function blockCode(node: Element) {
  if (node.name === 'pre') {
    BlockCode({ node: node })
  }
}

@Builder
function table(node: Element) {
  if (node.name === 'table') {
    Table({ node: node })
  }
}

@Builder
function hr(node: Element) {
  if (node.name === 'hr') {
    Divider()
  }
}

@Builder
function img(node: Element) {
  if (node.name === 'img') {
    Image(node.attribs['src'])
  }
}


@Component
struct H1 {
  @Require @Prop node: Element

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          InLineText(item, true)
        }, () => (num++).toString())
      }
    }
    .padding({
      bottom: 5
    })
    .borderColor("#ffb8b8b8")
    .borderWidth({
      bottom: 1,
    })
    .width("100%")
    .fontSize(26)
    .fontWeight(FontWeight.Bold)
  }
}

@Component
struct H2 {
  @Require @Prop node: Element

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          InLineText(item, true)
        }, () => (num++).toString())
      }
    }
    .width("100%")
    .padding({
      bottom: 5
    })
    .borderColor("#ffb8b8b8")
    .borderWidth({
      bottom: 1,
    })
    .fontSize(24)
    .fontWeight(FontWeight.Bold)
  }
}

@Component
struct H3 {
  @Require @Prop node: Element

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          InLineText(item, true)
        }, () => (num++).toString())
      }
    }
    .padding({
      bottom: 5
    })
    .borderColor("#ffb8b8b8")
    .borderWidth({
      bottom: 1,
    })
    .width("100%")
    .fontSize(22)
    .fontWeight(FontWeight.Bold)
  }
}

@Component
struct H4 {
  @Require @Prop node: Element

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          InLineText(item, true)
        }, () => (num++).toString())
      }
    }
    .padding({
      bottom: 5
    })
    .borderColor("#ffb8b8b8")
    .borderWidth({
      bottom: 1,
    })
    .width("100%")
    .fontSize(20)
    .fontWeight(FontWeight.Bold)
  }
}

@Component
struct H5 {
  @Require @Prop node: Element

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          InLineText(item, true)
        }, () => (num++).toString())
      }
    }
    .padding({
      bottom: 5
    })
    .borderColor("#ffb8b8b8")
    .borderWidth({
      bottom: 1,
    })
    .width("100%")
    .fontSize(18)
    .fontWeight(FontWeight.Bold)
  }
}

@Component
struct H6 {
  @Require @Prop node: Element

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          InLineText(item, true)
        }, () => (num++).toString())
      }
    }
    .width("100%")
    .padding({
      bottom: 5
    })
    .borderColor("#ffb8b8b8")
    .borderWidth({
      bottom: 1,
    })
    .fontSize(16)
    .fontWeight(FontWeight.Bold)
  }
}

@Component
struct P {
  @Require @Prop node: Element
  @State private other: Element[] = []

  build() {
    Text() {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode) => {
          if (isTag(item) && item.name === 'img') {
            ImageSpan(item.attribs["src"])
          } else {
            InLineText(item)
          }
        }, () => (num++).toString())
      }
    }
    .lineHeight(18)
    .width("100%")
    .fontSize(14)
  }
}

// ====== 引用块 ======
@Component
struct Blockquote {
  @Require @Prop node: Element
  @BuilderParam bolck: () => void = nullBuilder

  build() {
    Column() {
      this.bolck()
    }.border({
      width: {
        left: 3
      },
      color: Color.Blue
    })
    .alignItems(HorizontalAlign.Start)
    .padding(10)
    .width("100%")
  }
}

// ====== 列表 ======
@Component
struct UnOrderList {
  @Require @Prop node: Element
  @BuilderParam bolck: () => void = nullBuilder

  build() {
    Column({ space: 5 }) {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode, index) => {
          if (!isText(item)) {
            Row({ space: 5 }) {
              Text("•")
                .fontSize(14)
              Column({ space: 5 }) {
                HListItem({ node: item })
              }
            }
            .width("100%")
            .alignItems(VerticalAlign.Top)
          }
        }, () => (num++).toString())
      }
    }
    .width("100%")
  }
}

@Component
struct OrderList {
  @Require @Prop node: Element
  @BuilderParam bolck: () => void = nullBuilder
  private orderNum: number = 1

  build() {
    Column({ space: 5 }) {
      if (hasChildren(this.node)) {
        ForEach(this.node.children, (item: ChildNode, index) => {
          if (!isText(item)) {
            Row({ space: 5 }) {
              Text((this.orderNum++).toString())
                .fontSize(14)
              Column({ space: 5 }) {
                HListItem({ node: item })
              }
            }
            .width("100%")
            .alignItems(VerticalAlign.Top)
          }
        }, () => (num++).toString())
      }
    }
    .width("100%")
  }
}

@Component
struct HListItem {
  @Require @Prop node: ChildNode
  @BuilderParam bolck: () => void = nullBuilder

  build() {
    Column() {
      Text() {
        if (hasChildren(this.node)) {
          ForEach(this.node.children, (item: ChildNode) => {
            InLineText(item)
          }, () => (num++).toString())
        }
      }
      .fontSize(14)
    }
  }
}

// ======= 行内 ======

@Builder
function InLineText(node: ChildNode, bold: boolean = false) {
  if (node && isText(node)) {
    Span(node.data)
      .fontWeight(bold ? FontWeight.Bold : FontWeight.Normal)
  }
  else if (node && isTag(node) && hasChildren(node)) {
    if (DomUtils.getElementsByTagType(ElementType.Text, node)?.length > 0) {
      Span((DomUtils.getElementsByTagType(ElementType.Text, node) as DomText[])[0].data)
        .fontWeight(DomUtils.getElementsByTagName("b", node, true)
          .length > 0 || DomUtils.getElementsByTagName("strong", node, true)
          .length > 0 ? FontWeight.Bold : FontWeight.Normal)
        .fontStyle(DomUtils.getElementsByTagName("i", node, true)
          .length > 0 || DomUtils.getElementsByTagName("em", node, true)
          .length > 0 ? FontStyle.Italic : FontStyle.Normal)
        .textBackgroundStyle(DomUtils.getElementsByTagName("code", node, true).length > 0 ? {
          color: "#ffe3e3e3",
          radius: 2
        } : {
          color: Color.Transparent,
          radius: 0
        })
        .fontColor(DomUtils.getElementsByTagName("code", node, true).length > 0 ? "#ffee421e" : "#ff000000")
    }

  }
}

// @Component
// struct InLineText {
//   @Require @Prop node: ChildNode
//   bold: boolean = false
//   build() {
//     // if (isText(this.node)) {
//     //   Span(this.node.data)
//     //     .fontWeight(this.bold ? FontWeight.Bold : FontWeight.Normal)
//     // }
//     // else if (isTag(this.node) && hasChildren(this.node)) {
//     //   Span((DomUtils.getElementsByTagType(ElementType.Text, this.node)[0] as domText).data)
//     //     .fontWeight(DomUtils.getElementsByTagName("b", this.node, true)
//     //       .length > 0 || DomUtils.getElementsByTagName("strong", this.node, true)
//     //       .length > 0 ? FontWeight.Bold : FontWeight.Normal)
//     //     .fontStyle(DomUtils.getElementsByTagName("i", this.node, true)
//     //       .length > 0 || DomUtils.getElementsByTagName("em", this.node, true)
//     //       .length > 0 ? FontStyle.Italic : FontStyle.Normal)
//     //     .textBackgroundStyle(DomUtils.getElementsByTagName("code", this.node, true).length > 0 ? {
//     //       color: "#ffe3e3e3",
//     //       radius: 2
//     //     } : {
//     //       color: Color.Transparent,
//     //       radius: 0
//     //     })
//     //     .fontColor(DomUtils.getElementsByTagName("code", this.node, true).length > 0 ? "#ffee421e" : "#ff000000")
//     //
//     // }
//   }
// }

// 代码块
@Component
struct BlockCode {
  @Require @Prop node: ChildNode
  @BuilderParam line: () => void = nullBuilder

  build() {
    Scroll() {
      Text(DomUtils.textContent(this.node).trim())
        .fontSize(14)
    }
    .align(Alignment.TopStart)
    .scrollable(ScrollDirection.Horizontal)
    .width('100%')
    .padding(10)
    .backgroundColor("#ffe3e3e3")
  }
}

// 表格
@Component
struct Table {
  @Require @Prop node: ChildNode
  @BuilderParam line: () => void = nullBuilder
  @State private trs: Element[] = []
  @State private col: number = 0

  aboutToAppear(): void {
    this.trs = DomUtils.getElementsByTagName('tr', this.node, true)
    this.col = DomUtils.getElementsByTagName('th', this.node, true).length
  }

  build() {
    Column() {
      ForEach(this.trs, (tr: Element, index: number) => {
        if (index === 0 && hasChildren(tr)) {
          Row() {
            ForEach(tr.children, (th: ChildNode, index: number) => {
              if (isTag(th)) {
                Text() {
                  if (hasChildren(th)) {
                    ForEach(th.children, (item: ChildNode, index: number) => {
                      InLineText(th)
                    }, () => (num++).toString())
                  }
                }
                .padding(5)
                .layoutWeight(1)
                .fontSize(14)
              }
            }, () => (num++).toString())
          }
          .backgroundColor("#F0F0F0")
          // .justifyContent(FlexAlign.SpaceBetween)
          .width("100%")
        }
        else if (index !== 0 && hasChildren(tr)) {
          Row() {
            ForEach(tr.children, (td: ChildNode, index: number) => {
              if (isTag(td)) {
                Text() {
                  if (hasChildren(td)) {
                    ForEach(td.children, (item: ChildNode, index: number) => {
                      InLineText(td)
                    }, () => (num++).toString())
                  }
                }
                .fontSize(14)
                .padding(5)
                .layoutWeight(1)
              }
            }, () => (num++).toString())
          }
          .backgroundColor(index % 2 ? Color.Transparent : "#fffafafa")
          .width("100%")
        }
      }, () => (num++).toString())
    }
    .border({
      width: 0.5
    })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width("100%")
  }
}


@Component
struct HText {
  @Require @Prop node: ChildNode
  @Prop fontSize: number = 16
  @Prop fontWeight: FontWeight = FontWeight.Normal
  @BuilderParam line: () => void = nullBuilder

  build() {
    Text() {
      this.line()
    }
    .fontSize(this.fontSize)
    .fontWeight(this.fontWeight)
  }
}

@Builder
function nullBuilder() {
}