import { http } from '@kit.NetworkKit'
import { SobData, SobHeader } from '.'
import { resToObj } from './util'
import { promptAction, router } from '@kit.ArkUI'
import { UserAuthentication } from '../utils'

export class Send {
  static readonly base_url: string = "https://api.sunofbeaches.com"

  /**
   * 发送请求
   * @param url
   * @param method
   * @param extraData
   * @returns
   */
  private static async send(url: string,
                            method: http.RequestMethod,
                            extraData: Object | undefined = undefined,
                            expectDataType: http.HttpDataType | undefined = undefined,
                            header: SobHeader | undefined = undefined): Promise<http.HttpResponse> {

    const token: string = await UserAuthentication.getToken()
    if (token) {
      if (header) header.cookie = `sob_token=${token}`
      else header = { cookie: `sob_token=${token}` }
    }

    const conf: http.HttpRequestOptions = {
      method,
      extraData,
      header
    }
    const connect = http.createHttp()
    const res = await connect.request(url.includes('http') ? url : Send.base_url + url, conf)
    if (res.header["sob_token"]){
      UserAuthentication.setToken(res.header["sob_token"])
    }

    if (expectDataType === http.HttpDataType.ARRAY_BUFFER) {
      return res
    }

    const temp: SobData<null> = resToObj<SobData<null>>(res)
    if (temp.success) {
      return res
    }
    else {
      promptAction.showToast({
        message: temp.message
      })
      if (temp.code === 11126) {
        await router.pushUrl({
          url: 'pages/Login/Login'
        })
      }
      console.log(JSON.stringify(temp))
      throw new Error(JSON.stringify(temp))
    }
  }

  /**
   * get请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async get(url: string,
                          extraData: Object | undefined = undefined,
                          expectDataType: http.HttpDataType | undefined = undefined,
                          header: SobHeader | undefined = undefined): Promise<http.HttpResponse> {
    return await Send.send(url, http.RequestMethod.GET, extraData, expectDataType, header)
  }

  /**
   * post请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async post(url: string,
                           extraData: Object | undefined = undefined,
                           expectDataType: http.HttpDataType | undefined = undefined,
                           header: SobHeader | undefined = undefined): Promise<http.HttpResponse> {
    return await Send.send(url, http.RequestMethod.POST, extraData, expectDataType, header)
  }

  /**
   * put请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async put(url: string,
                           extraData: Object | undefined = undefined,
                           expectDataType: http.HttpDataType | undefined = undefined,
                           header: SobHeader | undefined = undefined): Promise<http.HttpResponse> {
    return await Send.send(url, http.RequestMethod.PUT, extraData, expectDataType, header)
  }

  /**
   * delete 请求
   * @param url
   * @param extraData
   * @param expectDataType
   * @param header
   * @returns
   */
  public static async delete(url: string,
                           extraData: Object | undefined = undefined,
                           expectDataType: http.HttpDataType | undefined = undefined,
                           header: SobHeader | undefined = undefined): Promise<http.HttpResponse> {
    return await Send.send(url, http.RequestMethod.DELETE, extraData, expectDataType, header)
  }



}