import { http } from '@kit.NetworkKit';

/**
 * 网络数据转对象
 * @param res
 * @returns
 */
export function  resToObj<T> (res: http.HttpResponse): T {
  if (typeof res.result === "string") {
    return JSON.parse(res.result) as T
  } else if (typeof res.result === "object") {
    return res.result as T
  }
  throw new Error("数据转换失败")
}