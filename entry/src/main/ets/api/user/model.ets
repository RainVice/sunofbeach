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


/**
 * 获取图灵码需要的参赛
 */
export interface CaptchaParam{ code: number }

/**
 * 登录账号密码参数
 */
export interface LoginParam{
  phoneNum: string
  password: string
}

/**
 * 检查token
 */
export interface UserToken{
  id: string;
  roles?: string;
  lev: number;
  isVip: string;
  avatar: string;
  nickname: string;
  token?: string;
  fansCount?: number;
  followCount?: number;
}

/**
 * 关注列表
 */
export interface Follow {
  userId: string
  nickname: string
  sign: string
  avatar: string
  relative: number
  vip: boolean
}













