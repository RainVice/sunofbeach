/**
 * 首页相关内容
 */
import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { Category, CtContent } from './model'
import { ListInfo, SunData } from '..'
import { resToObj } from '../util'

/**
 * 获取首页分类
 */
export const category = async (): Promise<Category[]> => {
  const res: http.HttpResponse = await Send.get("/ct/category/list")
  let category: Category[] = resToObj<SunData<Category[]>>(res).data
  return category
}

/**
 * 获取推荐内容
 * @param page 页码，从1开始
 */
export const recommend_content = async (page: number = 1): Promise<ListInfo<CtContent>> => {
  const res: http.HttpResponse = await Send.get(`/ct/content/home/recommend/${page}`)
  let recommend: ListInfo<CtContent> = resToObj<SunData<ListInfo<CtContent>>>(res).data
  return recommend
}