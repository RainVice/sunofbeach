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
interface CaptchaParam{ code: number }
export const captcha = async (code: number = Math.random()): Promise<Captcha> => {
  const res: http.HttpResponse = await Send.get(`/uc/ut/captcha`, { code: code } as CaptchaParam, http.HttpDataType.ARRAY_BUFFER)
  return {
    image: res.result as ArrayBuffer,
    l_c_i: res.header["l_c_i"]
  }
}

/**
 * 获取用户信息
 * @param userId 用户ID
 */
export const user_info = async (userId: string): Promise<UserInfo> => {
  const res: http.HttpResponse = await Send.get(`/uc/user-info/${userId}`)
  const userInfo: UserInfo = resToObj<SunData<UserInfo>>(res).data
  return userInfo
}

/**
 * 根据手机号获取用户头像
 * @param phoneNum 手机号
 */

export const avatar = async(phoneNum: string): Promise<string> => {
  const res: http.HttpResponse = await Send.get(`https://api.sunofbeach.net/uc/user/avatar/${phoneNum}`)
  const avatar: string = resToObj<SunData<string>>(res).data
  return avatar
}
