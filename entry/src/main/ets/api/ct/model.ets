
/**
 * 首页分类
 */
export interface Category {
  id?: string;
  categoryName: string;
  order?: number;
  description?: string;
  createTime?: string;
  pyName?: string;
}


/**
 * 首页推荐内容,根据分类获取内容
 */
export interface Content {
  covers: string[];
  title: string;
  createTime: string;
  thumbUp: number;
  viewCount: number;
  type: number;
  nickName: string;
  avatar: string;
  id: string;
  userId: string;
  isVip?: boolean;
  vip?: boolean
}
export interface Recommend {
  list: Content[];
  total: number;
  pageSize: number;
  currentPage: number;
  hasNext: boolean;
  hasPre: boolean;
  totalPage: number;
}


export const recommend: Category = {
  categoryName: "推荐"
}