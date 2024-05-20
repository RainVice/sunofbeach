import { DomUtils } from '@ohos/htmlparser2'
import { ChildNode } from 'domhandler'
import { blockquote, bold,
  check,
  code,
  definitionDescription,
  definitionTerm,
  deleteLine,
  descriptionList,
  divider,
  header,
  image,
  italic, lineBreak,
  link,
  listItem,
  orderedList,
  paragraph,
  preformatted,
  root,
  tableBody,
  tableDataCell,
  tableHeader,
  tableHeaderCell,
  tableRowCell,
  text,
  unorderedList } from '../plugins'

export class MDNode {
  private htmlNode: ChildNode
  private mdType: MDType
  private childNode: MDNode[] = []

  static createForHtml(htmlNode: ChildNode): MDNode {
    const mdNode = new MDNode()
    mdNode.htmlNode = htmlNode
    if (htmlNode.type === "text") {
      mdNode.mdType = htmlTagMap[htmlNode.type]
    }
    else if (htmlNode.type === 'root') {
      mdNode.mdType = MDType.Root
    }
    else if (htmlNode.type === "tag") {
      if (htmlNode.name === "input") {
        mdNode.mdType = htmlTagMap[htmlNode.attribs['type']]
      }
      else {
        mdNode.mdType = htmlTagMap[htmlNode.name]
      }
    }
    return mdNode
  }

  pushNode(mdNode: MDNode) {
    this.childNode.push(mdNode)
  }

  outputMd(): string {
    const action = !!outputRules[this.mdType] ? outputRules[this.mdType](this) : (text: string):string => text
    let text = ''
    this.childNode.forEach((item: MDNode, index: number) => {
      text += item.outputMd()
    })
    return action(text)
  }

  innerText(): string {
    return DomUtils.innerText(this.htmlNode)
  }


  type(): MDType {
    return this.mdType
  }

  html(): ChildNode {
    return this.htmlNode
  }


  // 从 markdown 节点创建
  // static createForMd(mdType: MDType): MDNode{
  //
  // }
}


// 未实现的功能：
// - 转义字符与内嵌HTML
// - 脚注
// - 使用 Emoji 表情
// - 自动网址链接
export enum MDType {
  // 根节点类型
  Root = "root",

  // 标题类型，从H1到H6
  Header1 = "header1",
  Header2 = "header2",
  Header3 = "header3",
  Header4 = "header4",
  Header5 = "header5",
  Header6 = "header6",

  // 普通文本
  Text = "text",

  // 段落类型
  Paragraph = "paragraph",
  DeleteLine = "delete line", // 删除线文本

  // 换行符
  LineBreak = "lineBreak",

  // 强调类型
  Bold = "bold", // 粗体
  Italic = "italic", // 斜体

  // 引用
  Quote = "quote",

  // 列表类型
  OrderedList = "ordered list", // 有序列表
  UnorderedList = "unordered list", // 无序列表
  ListItem = "list item", // 列表项
  Check = "check", // 复选框

  // 代码类型
  Code = "code", // 行内代码
  Preformatted = "preformatted", // 预格式化文本（通常用于代码块）

  // 分隔线
  Divider = "divider",

  // 链接
  Link = "link",

  // 图片
  Image = "image",

  // 表格类型
  Table = "table", // 表格
  TableHeader = "table header", // 表格头部
  TableHeaderCell = "table header cell", // 表头单元格
  TableBody = "table body", // 表格主体
  TableRowCell = "table row cell", // 行单元格
  TableDataCell = "table data cell", // 数据单元格

  // 定义列表类型
  DescriptionList = "description list", // 描述列表
  DefinitionTerm = "definition term", // 定义项
  DefinitionDescription = "definition description", // 定义描述

  Undefined = "undefined", // 定义描述
}

// 创建一个映射对象，将HTML标签映射到MDType枚举
const htmlTagMap: { [key: string]: MDType } = {
  'root': MDType.Root,

  'h1': MDType.Header1,
  'h2': MDType.Header2,
  'h3': MDType.Header3,
  'h4': MDType.Header4,
  'h5': MDType.Header5,
  'h6': MDType.Header6,

  'text': MDType.Text,

  'p': MDType.Paragraph,
  's': MDType.DeleteLine,
  'del': MDType.DeleteLine,

  'br': MDType.LineBreak,

  'strong': MDType.Bold,
  'b': MDType.Bold,
  'i': MDType.Italic,
  'em': MDType.Italic,

  'blockquote': MDType.Quote,
  'ul': MDType.UnorderedList,
  'ol': MDType.OrderedList,
  'li': MDType.ListItem,
  'checkbox': MDType.Check,

  // 'a' 标签在 Markdown 中通常表示链接，但 HTML 中可以有不同的语义，这里假设它映射到 Link
  'a': MDType.Link,
  // 'code' 和 'pre' 标签在 Markdown 中分别表示行内代码和预格式化文本
  'code': MDType.Code,
  'pre': MDType.Preformatted,
  'hr': MDType.Divider,
  // 'img' 标签在 HTML 中用于图片，在 Markdown 中通常用 `![alt text](url)` 表示
  'img': MDType.Image,
  // 表格相关标签
  'table': MDType.Table,
  'thead': MDType.TableHeader,
  'tbody': MDType.TableBody,
  'tr': MDType.TableRowCell, // 行通常表示为 table row cell
  'th': MDType.TableHeaderCell,
  'td': MDType.TableDataCell,
  // 定义列表相关标签
  'dl': MDType.DescriptionList,
  'dt': MDType.DefinitionTerm,
  'dd': MDType.DefinitionDescription,

};

const outputRules: { [key: string]: (mdNode: MDNode) => (text: string) => string } = {
  [MDType.Root]: root,
  [MDType.Header1]: header,
  [MDType.Header2]: header,
  [MDType.Header3]: header,
  [MDType.Header4]: header,
  [MDType.Header5]: header,
  [MDType.Header6]: header,
  [MDType.Text]: text,
  [MDType.Paragraph]: paragraph,
  [MDType.DeleteLine]: deleteLine,
  [MDType.LineBreak]: lineBreak,
  [MDType.Bold]: bold,
  [MDType.Italic]: italic,
  [MDType.Quote]: blockquote,
  [MDType.UnorderedList]: unorderedList,
  [MDType.OrderedList]: orderedList,
  [MDType.ListItem]: listItem,
  [MDType.Check]: check,
  [MDType.Link]: link,
  [MDType.Code]: code,
  [MDType.Preformatted]: preformatted,
  [MDType.Divider]: divider,
  [MDType.Image]: image,
  [MDType.TableDataCell]: tableDataCell,
  [MDType.TableRowCell]: tableRowCell,
  [MDType.TableBody]: tableBody,
  [MDType.TableHeaderCell]: tableHeaderCell,
  [MDType.TableHeader]: tableHeader,
  [MDType.DefinitionTerm]: definitionTerm,
  [MDType.DefinitionDescription]: definitionDescription,
  [MDType.DescriptionList]: descriptionList,


}
