export interface WenDaTab{
  name: ResourceStr
  state: string
}


export const wendaTabs:WenDaTab[] = [
  {name: $r('app.string.lastest'),state: "lastest"},
  {name: $r('app.string.noanswer'),state: "noanswer"},
  {name: $r('app.string.hot'),state: "hot"},
]