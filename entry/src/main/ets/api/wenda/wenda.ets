import { Answer, WendaComment, WenDaDetail, WenDaList } from '.'
import { ListInfo, SobData } from '..'
import { Send } from '../send'
import { resToObj } from '../util'
import { http } from '@kit.NetworkKit'

/**
 * 获取问题列表
 * page参数，页码，从1开始
 * state，状态：lastest最新的，noanswer等待解决的，hot热门的
 * category：-2
 */
export const wenda_list = async (page: number, state: string): Promise<ListInfo<WenDaList>> => {
  const res: http.HttpResponse = await Send.get(`/ct/wenda/list?page=${page}&state=${state}&category=-2`)
  const wendaList: ListInfo<WenDaList> = resToObj<SobData<ListInfo<WenDaList>>>(res).data
  return wendaList
}


/**
 * 获取问题详情
 * @param wendaId 问答 ID
 */
export const wenda_detail = async (wendaId: string = ""): Promise<WenDaDetail> => {
  const res: http.HttpResponse = await Send.get(`/ct/wenda/${wendaId}`)
  const wendaDetail: WenDaDetail = resToObj<SobData<WenDaDetail>>(res).data
  return wendaDetail
}

/**
 * 获取答案列表
 * @param wendaId参数：问题的Id
 * @param page参数：页码，从第1页开始
 */
export const comment_list = async (wendaId: string = "", page: number = 1): Promise<WendaComment[]> => {
  const res: http.HttpResponse = await Send.get(`/ct/wenda/comment/list/${wendaId}/${page}`)
  const saum: WendaComment[] = resToObj<SobData<WendaComment[]>>(res).data
  return saum
}

/**
 * 获取指定用户回答列表
 * https://api.sunofbeach.net/ct/wenda/comment/list/user/1153952789488054272/1
 */
export const wenda4user = async (uid: string = "", page: number): Promise<Answer> => {
  const res: http.HttpResponse = await Send.get(`https://api.sunofbeach.net/ct/wenda/comment/list/user/${uid}/${page}`)
  const result: Answer = resToObj<SobData<Answer>>(res).data
  return result
}


