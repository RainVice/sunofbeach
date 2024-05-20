import { HTMLParser } from './parser'

export class HmdConv{


  constructor() {
  }


  html2md(input: string): string{
    const html = new HTMLParser(input)
    return html.start()
  }


  md2html(md: string){

  }


}

export * from './parser'