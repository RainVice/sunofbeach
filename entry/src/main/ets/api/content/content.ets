/**
 * 首页相关内容
 */
import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { ArticleDetail, Category, Comment, CommentParam, CtContent, SubCommentParam } from './model'
import { ListInfo, ListInfoModel, SobData } from '..'
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
export const content = async (categoryId: string = '', page: number = 1): Promise<ListInfoModel<CtContent>> => {
  const res: http.HttpResponse =
    await Send.get(`/ct/content/home/recommend${categoryId ? `/${categoryId}` : ''}/${page}`)
  let recommend: ListInfoModel<CtContent> = resToObj<SobData<ListInfoModel<CtContent>>>(res).data
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


/**
 * 评论文章
 * parentId，默认为0即可
 * articlId，文章的ID
 * commentConetnt，评论内容
 */
export const comment = async (articleId: string, commentContent: string): Promise<boolean> => {
  const res: http.HttpResponse = await Send.post('/ct/article/comment', {
    parentId: "0",
    articleId,
    commentContent
  } as CommentParam)
  let result: SobData<null> = resToObj<SobData<null>>(res)
  return result.success
}


/**
 * 回复文章评论
 * articleId，文章Id
 * parentId，被回复评论的Id
 * beUid，被评论用户的Id
 * beNickname，被评论用户的昵称
 * content,评论内容
 */
export const sub_comment =
  async (articleId: string, parentId: string, beUid: string, beNickname: string, content: string): Promise<boolean> => {
    const res: http.HttpResponse = await Send.post('/ct/article/sub-comment', {
      articleId,
      parentId,
      beUid,
      beNickname,
      content
    } as SubCommentParam)
    let result: SobData<null> = resToObj<SobData<null>>(res)
    return result.success
  }

/**
 * 获取指定用户发布的文章
 * https://api.sunofbeach.net/ct/article/list/1153952789488054272/1
 */
export const article4user = async (uid: string = "", page: number): Promise<ListInfo<CtContent>> => {
  const res: http.HttpResponse = await Send.get(`https://api.sunofbeach.net/ct/article/list/${uid}/${page}`)
  const result: ListInfo<CtContent> = resToObj<SobData<ListInfo<CtContent>>>(res).data
  return result
}