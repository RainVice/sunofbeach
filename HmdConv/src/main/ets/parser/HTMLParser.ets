import { Document, DomUtils, parseDocument } from '@ohos/htmlparser2'
import { ChildNode } from 'domhandler'
import { MDNode } from '../node'


export class HTMLParser{
  private dom: Document
  private mdNode: MDNode

  constructor(html: string) {
    this.dom = parseDocument(html)
    this.mdNode = MDNode.createForHtml(this.dom)
  }

  traverseDOM(childNode: ChildNode, _mdNode: MDNode){
    const temp = MDNode.createForHtml(childNode)
    _mdNode.pushNode(temp)
    if (DomUtils.hasChildren(childNode)) {
      childNode.children.forEach((item: ChildNode,index:number) => {
        this.traverseDOM(item,temp)
      })
    }
  }



  start() : string{
    this.traverseDOM(this.dom,this.mdNode)
    const aaa: string = this.mdNode.outputMd()
    return aaa
  }



}