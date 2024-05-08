/**
 * 用户相关内容
 */
import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { Captcha, UserInfo } from './model'
import { resToObj } from '../util'
import { SunData } from '..'

/**
 * 获取图灵码
 * @param code 随机数
 */
export const captcha = async (code: number): Promise<Captcha> => {
  const res : http.HttpResponse = await Send.get("/uc/ut/captcha")
  return {
    image: res.result as ArrayBuffer,
    l_c_i: res.header["l_c_i"]
  }
}


export const user_info = async (userId: string): Promise<UserInfo> => {
  const res : http.HttpResponse = await Send.get(`/uc/user-info/${userId}`)
  const userInfo: UserInfo = resToObj<SunData<UserInfo>>(res).data
  return userInfo
}

