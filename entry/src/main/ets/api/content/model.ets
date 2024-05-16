
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
export const recommend: Category = {
  categoryName: "推荐"
}


/**
 * 首页推荐内容,根据分类获取内容
 */
export interface CtContent {
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
@Observed
export class CtContentModel implements CtContent{
  covers: string[] = [];
  title: string = '';
  createTime: string = '';
  thumbUp: number = 0;
  viewCount: number = 0;
  type: number = 0;
  nickName: string = '';
  avatar: string = '';
  id: string = '';
  userId: string = '';
  isVip?: boolean | undefined;
  vip?: boolean | undefined;
}

/**
 * 文章详情
 */
export interface ArticleDetail {
  id: string;
  title: string;
  userId: string;
  categoryId: string;
  categoryName: string;
  contentType: string;
  content: string;
  createTime: string;
  labels: string[];
  viewCount: number;
  thumbUp: number;
  recommend: number;
  covers: string[];
  articleType: string;
  avatar: string;
  isVip: string;
  nickname: string;
  isTop: string;
  isComment: string;
  state: string;
}