/**
 * 首页相关内容
 */
import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { ArticleDetail, Category, Comment, CtContent, CtContentModel } from './model'
import { ListInfoModel, SobData } from '..'
import { resToObj } from '../util'

/**
 * 获取首页分类
 */
export const category = async (): Promise<Category[]> => {
  const res: http.HttpResponse = await Send.get("/ct/category/list")
  let category: Category[] = resToObj<SobData<Category[]>>(res).data
  return category
}

/**
 * 获取文章内容
 * @param page 页码，从1开始
 */
export const content = async (categoryId: string = '', page: number = 1): Promise<ListInfoModel<CtContentModel>> => {
  const res: http.HttpResponse = await Send.get(`/ct/content/home/recommend${categoryId? `/${categoryId}` : ''}/${page}`)
  let recommend: ListInfoModel<CtContentModel> = resToObj<SobData<ListInfoModel<CtContentModel>>>(res).data
  return recommend
}

/**
 * 获取文章详情
 */
export const article_detail = async (articleId: string): Promise<ArticleDetail> => {
  const res: http.HttpResponse = await Send.get(`/ct/article/detail/${articleId}`)
  let articleDetail: ArticleDetail = resToObj<SobData<ArticleDetail>>(res).data
  return articleDetail
}


/**
 * 获取文章评论
 * articleId: 文章Id
 * page: 页码，从1开始
 */
export const article_comment = async (articleId: string, page: number): Promise<Comment> => {
  const res: http.HttpResponse = await Send.get(`/ct/article/comment/${articleId}/${page}`)
  let comment: Comment = resToObj<SobData<Comment>>(res).data
  return comment
}
