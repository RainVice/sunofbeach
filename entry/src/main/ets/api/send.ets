import { http } from '@kit.NetworkKit'
import { SunData } from '.'
import { resToObj } from './util'
import { promptAction, router } from '@kit.ArkUI'

export class Send {
  static readonly base_url: string = "https://api.sunofbeaches.com"

  /**
   * 发送请求
   * @param url
   * @param method
   * @param extraData
   * @returns
   */
  private static async send(url: string, method: http.RequestMethod, extraData: Object | undefined, expectDataType: http.HttpDataType | undefined): Promise<http.HttpResponse> {
    const conf: http.HttpRequestOptions = extraData ? {
      method,
      extraData,
    } : { method }
    const connect = http.createHttp()
    const res = await connect.request(url.includes('http') ? url : Send.base_url + url, conf)

    if (expectDataType === http.HttpDataType.ARRAY_BUFFER) {
      return res
    }

    const temp: SunData<null> = resToObj<SunData<null>>(res)
    if (temp.success) {
      return res
    }
    else {
      promptAction.showToast({
        message: temp.message
      })
      if (temp.code === 11126) {
        router.pushUrl({
          url: 'pages/Login/Login'
        })
      }
      throw new Error(JSON.stringify(temp))
    }
  }

  /**
   * get请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async get(url: string, extraData: Object | undefined = undefined, expectDataType: http.HttpDataType | undefined = undefined): Promise<http.HttpResponse> {
    return await Send.send(url, http.RequestMethod.GET, extraData, expectDataType)
  }

  /**
   * post请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async post(url: string, extraData: Object | undefined = undefined, expectDataType: http.HttpDataType | undefined = undefined): Promise<http.HttpResponse> {
    return await Send.send(url, http.RequestMethod.POST, extraData, expectDataType)
  }
}