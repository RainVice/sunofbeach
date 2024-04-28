import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { TopicIndex } from './model'
import { SunData } from '..'
import { resToObj } from '../util'


/**
 * 获取话题列表
 */
export const topic = async (): Promise<TopicIndex[]> => {
  const res: http.HttpResponse = await Send.get("/ct/moyu/topic/index")
  let topicIndex: TopicIndex[] = resToObj<SunData<TopicIndex[]>>(res).data
  return topicIndex
}
