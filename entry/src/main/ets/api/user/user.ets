/**
 * 用户相关内容
 */
import { Send } from '../send'
import { http } from '@kit.NetworkKit'
import { Captcha, CaptchaParam, LoginParam, UserInfo } from './model'
import { resToObj } from '../util'
import { SunData } from '..'
import { cryptoFramework } from '@kit.CryptoArchitectureKit'
import { buffer, util } from '@kit.ArkTS'
import { promptAction } from '@kit.ArkUI'
import { UserAuthentication } from '../../utils'

/**
 * 获取图灵码
 * @param code 随机数
 */

export const captcha = async (code: number = Math.random()): Promise<Captcha> => {
  const res: http.HttpResponse = await Send.get(`/uc/ut/captcha`, {
    code: code
  } as CaptchaParam, http.HttpDataType.ARRAY_BUFFER)
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

export const avatar = async (phoneNum: string): Promise<string> => {
  const res: http.HttpResponse = await Send.get(`https://api.sunofbeach.net/uc/user/avatar/${phoneNum}`)
  const avatar: string = resToObj<SunData<string>>(res).data
  return avatar
}

/**
 * 登录
 */
export const login = async (phoneNum: string, password: string, captcha: string, l_c_i: string | undefined) : Promise<boolean> => {
  const md5 = cryptoFramework.createMd('MD5')
  await md5.update({ data: new Uint8Array(buffer.from(password).buffer) })
  password = buffer.from((await md5.digest()).data).toString('hex')
  const res = await Send.post(`/uc/user/login/${captcha}`, { phoneNum, password } as LoginParam, undefined, { l_c_i })
  const message: SunData<undefined> = resToObj<SunData<undefined>>(res)
  if (message.success) {
    UserAuthentication.setToken(res.header["sob_token"])
  }else{
    promptAction.showToast({
      message: message.message
    })
  }
  return message.success
}
