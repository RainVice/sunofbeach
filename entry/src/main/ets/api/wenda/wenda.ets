import { WenDaList } from '.'
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