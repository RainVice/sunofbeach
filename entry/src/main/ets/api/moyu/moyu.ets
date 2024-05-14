import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { Datum, MoyuComment, MoyuContent, TopicIndex, topicIndexs } from './model'
import { ListInfo, SunData } from '..'
import { resToObj } from '../util'


/**
 * 获取首页话题列表
 */
export const topic = async (): Promise<TopicIndex[]> => {
  const res: http.HttpResponse = await Send.get("/ct/moyu/topic/index")
  const topicIndex: TopicIndex[] = resToObj<SunData<TopicIndex[]>>(res).data
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
  const moyu: ListInfo<MoyuContent> = resToObj<SunData<ListInfo<MoyuContent>>>(res).data
  return moyu
}

/**
 * 获取评论列表
 * momentId：动态的ID
 * page：页码，第1页开始
 * sort：1表示按时间降序，旧的在后面，0表示按时间升序，新的在后面
 */
export const comment = async (momentId: string, page: number = 1, sort: number = 1): Promise<ListInfo<MoyuComment>>   => {
  const res: http.HttpResponse = await Send.get(`/ct/moyu/comment/${momentId}/${page}?sort=${sort}`)
  const comment: ListInfo<MoyuComment> = resToObj<SunData<ListInfo<MoyuComment>>>(res).data
  return comment
}

/**
 * 获取话题列表
 */
export const allTopic = async (): Promise<Datum[]> => {
  const res: http.HttpResponse = await Send.get('/ct/moyu/topic')
  const datum: Datum[] = resToObj<SunData<Datum[]>>(res).data
  return datum
}


