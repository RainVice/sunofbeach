/**
 * 用户相关内容
 */
import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { Captcha } from './model'

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