import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { CommentParam, Datum, MoyuComment, MoyuContent, SubCommentParam, TopicIndex, topicIndexs } from './model'
import { ListInfo, SobData } from '..'
import { resToObj } from '../util'
import { promptAction } from '@kit.ArkUI'


/**
 * 获取首页话题列表
 */
export const topic = async (): Promise<TopicIndex[]> => {
  const res: http.HttpResponse = await Send.get("/ct/moyu/topic/index")
  const topicIndex: TopicIndex[] = resToObj<SobData<TopicIndex[]>>(res).data
  topicIndex.unshift(...topicIndexs)
  return topicIndex
}


/**
 * 获取动态列表
 * topicId 话题Id，其中推荐为recommend，获取关注的为 follow 其他的则是话题的id
 * page 为页码，从1开始
 */
export const listForTopicId = async (topicId: string, page: number): Promise<ListInfo<MoyuContent>> => {
  const res: http.HttpResponse = await Send.get(`/ct/moyu/list/${topicId}/${page}`)
  if (topicId === 'follow') {
    console.log(JSON.stringify(res));
  }
  const moyu: ListInfo<MoyuContent> = resToObj<SobData<ListInfo<MoyuContent>>>(res).data
  return moyu
}

/**
 * 获取评论列表
 * momentId：动态的ID
 * page：页码，第1页开始
 * sort：1表示按时间降序，旧的在后面，0表示按时间升序，新的在后面
 */
export const commentList = async (momentId: string, page: number = 1, sort: number = 1): Promise<ListInfo<MoyuComment>> => {
  const res: http.HttpResponse = await Send.get(`/ct/moyu/comment/${momentId}/${page}?sort=${sort}`)
  const comment: ListInfo<MoyuComment> = resToObj<SobData<ListInfo<MoyuComment>>>(res).data
  return comment
}

/**
 * 获取话题列表
 */
export const allTopic = async (): Promise<Datum[]> => {
  const res: http.HttpResponse = await Send.get('/ct/moyu/topic')
  const datum: Datum[] = resToObj<SobData<Datum[]>>(res).data
  return datum
}

/**
 * 关注话题
 */
export const followTopic = async (id: string): Promise<boolean> => {
  const res: http.HttpResponse = await Send.post(`/ct/moyu/topic/follow/${id}`)
  const data: SobData<undefined> = resToObj<SobData<undefined>>(res)
  promptAction.showToast({
    message: data.message
  })
  return data.success
}

/**
 * 取消关注话题
 */
export const unfollowTopic = async (id: string): Promise<boolean> => {
  const res: http.HttpResponse = await Send.delete(`/ct/moyu/topic/follow/${id}`)
  const data: SobData<undefined> = resToObj<SobData<undefined>>(res)
  promptAction.showToast({
    message: data.message
  })
  return data.success
}

/**
 * 发表评论
 */
export const comment = async (momentId: string, content: string): Promise<boolean> => {
  const res: http.HttpResponse = await Send.post('/ct/moyu/comment', { momentId, content } as CommentParam)
  const result: SobData<undefined> = resToObj<SobData<undefined>>(res)
  if (!result.success) {
    promptAction.showToast({
      message: result.message
    })
  }
  return result.success
}

/**
 * 回复评论
 * content为评论内容，
 * momentId为动态Id，
 * targetUserId是被评论内容的用户Id，
 * commentId为被评论内容的Id
 */

export const sub_comment = async (param: SubCommentParam): Promise<boolean> => {
  const res: http.HttpResponse = await Send.post('/ct/moyu/sub-comment',param)
  const result: SobData<undefined> = resToObj<SobData<undefined>>(res)
  if (!result.success) {
    promptAction.showToast({
      message: result.message
    })
  }
  return result.success
}

