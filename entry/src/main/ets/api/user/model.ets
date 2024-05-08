/**
 * 图灵验证码数据
 */
export interface Captcha{
  image: ArrayBuffer
  l_c_i: string
}

/**
 * 用户信息
 */
export interface UserInfo {
  userId: string;
  nickname: string;
  avatar: string;
  position: string;
  company: string;
  sign: string;
  area: string;
  vip: boolean;
}