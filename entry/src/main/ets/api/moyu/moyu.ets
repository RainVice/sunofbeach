import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { MoyuContent, TopicIndex, topicIndexs } from './model'
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
 */
export const listForTopicId = async (topicId: string,page: number): Promise<ListInfo<MoyuContent>> => {
  const res: http.HttpResponse = await Send.get(`/ct/moyu/list/${topicId}/${page}`)
  const moyu: ListInfo<MoyuContent> = resToObj<SunData<ListInfo<MoyuContent>>>(res).data
  return moyu
}