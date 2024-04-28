import { http } from '@kit.NetworkKit'

export class Send{

  static readonly base_url: string = "https://api.sunofbeaches.com"

  /**
   * 发送请求
   * @param url
   * @param method
   * @param extraData
   * @returns
   */
  private static async send(url: string, method: http.RequestMethod,extraData: Object | null): Promise<http.HttpResponse>{
    const conf: http.HttpRequestOptions = extraData ? {
      method,
      extraData
    } : {method}
    const connect = http.createHttp()
    return await connect.request(Send.base_url + url,conf)
  }
  /**
   * get请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async get(url: string,extraData: Object | null = null): Promise<http.HttpResponse>{
    return await Send.send(url,http.RequestMethod.GET,extraData)
  }
  /**
   * post请求
   * @param url
   * @param extraData
   * @returns
   */
  public static async post(url: string,extraData: Object | null = null): Promise<http.HttpResponse>{
    return await Send.send(url,http.RequestMethod.POST,extraData)
  }


}