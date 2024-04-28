
export interface IndexItem {
  title: ResourceStr
  icon: ResourceStr
  menu: Array<NavigationMenuItem> | CustomBuilder
}
// 各页面数据
export const indexItems: IndexItem[] = [
  {
    title: $r('app.string.dawdling'),
    icon: $r('app.media.ic_public_home_filled'),
    menu: [
      {
        value: "搜索", icon: 'pages/Index/icon/search.svg', action: () => {
      }
      }
    ]
  },
  {
    title: $r('app.string.article'),
    icon: $r('app.media.ic_public_edit_filled'),
    menu: [
      {
        value: "搜索", icon: 'pages/Index/icon/search.svg', action: () => {
      }
      }
    ]
  },
  {
    title: $r('app.string.question'),
    icon: $r('app.media.ic_public_search_filled'),
    menu: [
      {
        value: "搜索", icon: 'pages/Index/icon/search.svg', action: () => {
      }
      }
    ]
  },
  {
    title: $r('app.string.user'),
    icon: $r('app.media.ic_user_portrait'),
    menu: [
      {
        value: "搜索", icon: 'pages/Index/icon/search.svg', action: () => {
      }
      }
    ]
  },
]