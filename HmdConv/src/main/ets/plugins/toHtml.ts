import { DomUtils } from '@ohos/htmlparser2'
import { Element, Text } from 'domhandler'
import { MDNode } from '../node'

export const root = (mdNode: MDNode): (text: string) => string => {
  return (text: string): string => text
}

export const header = (mdNode: MDNode): (text: string) => string => {
  return (text: string): string => '\n' + `${"#".repeat(parseInt(mdNode.type().slice(-1)))} ${text}` + '\n'
}

export const paragraph = (mdNode: MDNode): (text: string) => string => {
  return (text: string): string => '\n\n' + text + '\n\n'
}

export const text = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => (mdNode.html() as Text).data.trim() + text
}

export const deleteLine = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => `~~${text}~~`
}


export const lineBreak = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => '\n\n' + text
}


export const bold = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => ` **${text.trim()}** `
}

export const italic = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => ` *${text.trim()}* `

}

export const blockquote = (mdNode: MDNode): (text: string) => string => {


  return (text: string) => '\n' + text.trim().replace(/(\n\s*\n)+/g, '\n\n').replace(/^/gm, '> ') + '\n'

}


export const unorderedList = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => '\n' + text.trim()
    .replace(/(\n\s*\n)+/g, '\n\n')
    .split('\n')
    .filter(Boolean)
    .map((line, i) => (line.match(/^    /) ? line : `- ${line}`))
    .join('\n') + '\n\n'

}

export const orderedList = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => {
    const lines = text.trim()
      .replace(/(\n\s*\n)+/g, '\n')
      .split('\n')
    let count = 1; // 用于计数的变量
    return '\n' + lines.map(line => {
      if (line.startsWith('    ')) {
        // 如果行以四个空格开头，则不添加序号，直接返回该行
        return line;
      } else {
        // 否则，为非空行添加序号
        return `${count++}. ${line}`;
      }
    }).join('\n') + '\n\n'
  }
}

export const listItem = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => '\n' + text.split('\n').map((line, index) => index > 0 ? '    ' + line : line).join('\n')
}

export const check = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => DomUtils.hasAttrib(mdNode.html() as Element, "checked") ? `[x] ${text}` : `[ ] ${text}`
}


export const link = (mdNode: MDNode): (text: string) => string => {
  const element = mdNode.html() as Element
  const url = element.attribs['href']
  const title = element.attribs['title']
  return (text: string) => `[${text || ""}](${url || ""} "${title || ""}")`
}

export const code = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => /`(.*?)`/g.test(text.replace(/^`|`$/g, '')) ?
    '``' + text.replace(/^`|`$/g, '') + '``' :
    '`' + text.replace(/^`|`$/g, '') + '`'
}


export const preformatted = (mdNode: MDNode): (text: string) => string => {
  const lang = (mdNode.html() as Element).attribs["data-lang"] ||
  DomUtils.getElementsByTagName('code', mdNode.html())[0].attribs["class"]?.split('-')[1] ||
    ""
  return (text: string) =>
  '```' + lang + '\n' + text.replace(/^`|`$/g, '') + '\n```'
}


export const divider = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => '\n---\n' + text
}

export const image = (mdNode: MDNode): (text: string) => string => {
  const element = mdNode.html() as Element
  const url = element.attribs['src']
  const title = element.attribs['title']
  const alt = element.attribs['alt']
  return (text: string) => `![${alt}](${url} "${title}")`
}


export const tableDataCell = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => ` ${text} `
}


export const tableHeaderCell = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => ` ${text} `
}
export const tableHeader = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => text.replace(/^(?!\s*$).*$/gm, "|$&|")
}

export const tableRowCell = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => '\n' + text.replace('  ', ' | ')
}

export const tableBody = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => {
    const body = text.replace(/^(?!\s*$).*$/gm, "|$&|")
    const line = '\n' + `| ${' --- |'.repeat(body.match(/^\s*?(\S.*)(?=\n|$)/)[1].match(/\|/g)?.length - 1 || 0)}`
    return line + body
  }
}



export const definitionTerm = (mdNode: MDNode): (text: string) => string => {
  return (text: string) =>'\n'+  text
}


export const definitionDescription = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => '\n'+ `: ${text}` + '\n'
}



export const descriptionList = (mdNode: MDNode): (text: string) => string => {
  return (text: string) => text
}















