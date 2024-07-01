
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
  vip?: boolean;
  labels: string[];
  state: string | null;
  articleType: string | null
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


/**
 * 评论详情
 */
export interface SubComment {
  _id: string;
  parentId: string;
  beUid: string;
  beNickname: string;
  yourAvatar: string;
  yourRole: string;
  yourNickname: string;
  yourUid: string;
  content: string;
  publishTime: string;
  articleId: string;
  isVip: boolean;
}
export interface Content {
  _id: string;
  articleId: string;
  commentContent: string;
  userId: string;
  avatar: string;
  nickname: string;
  publishTime: string;
  parentId: string;
  role?: string;
  isTop: string;
  isVip: boolean;
  subComments: SubComment[];
}
export interface Order {
  direction: string;
  property: string;
  ignoreCase: boolean;
  nullHandling: string;
}
export interface Sort {
  orders: Order[];
}
export interface Pageable {
  sort: Sort;
  page: number;
  size: number;
}
export interface Comment {
  total: number;
  content: Content[];
  pageable: Pageable;
}


/**
 * 评论文章参数
 */
export interface CommentParam {
  parentId: string
  articleId: string
  commentContent: string
}

/**
 * 回复子评论参数
 */
export interface SubCommentParam {
  articleId: string;
  parentId: string;
  beUid: string;
  beNickname: string;
  content: string;
}