import { Article } from '../pages/Index/Article/Article'
import { Dawdling } from '../pages/Index/Dawdling/Dawdling'
import { Question } from '../pages/Index/Question/Question'
import { User } from '../pages/Index/User/User'

export interface IndexItem {
  title: ResourceStr
  icon: ResourceStr
  page: CustomBuilder
  menu: Array<NavigationMenuItem> | CustomBuilder
}
// 各页面数据
export const indexItems: IndexItem[] = [
  {
    title: $r('app.string.dawdling'),
    icon: $r('app.media.ic_public_home_filled'),
    page: () => {
      Dawdling()
    },
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
    page: () => {
      Article()
    },
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
    page: () => {
      Question()
    },
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
    page: () => {
      User()
    },
    menu: [
      {
        value: "搜索", icon: 'pages/Index/icon/search.svg', action: () => {
      }
      }
    ]
  },
]