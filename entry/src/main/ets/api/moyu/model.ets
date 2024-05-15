/**
 * 获取话题列表
 */
export interface TopicIndex {
  id: string;
  topicName: string;
  followCount?: number;
  contentCount?: number;
  cover?: string | null;
  order?: number;
  description?: string | null;
  createTime?: string | null;
  updateTime?: string | null;
}

export const topicIndexs: TopicIndex[] = [
  { topicName: "关注", id: "follow" },
  { topicName: "推荐", id: "recommend" },
]


/**
 * 摸鱼动态列表，发表动态返回值
 */
export interface MoyuContent {
  id: string;
  userId: string;
  nickname: string;
  avatar: string;
  company?: string;
  position?: string;
  content: string;
  linkCover?: string;
  linkTitle?: string;
  linkUrl?: string;
  commentCount: number;
  thumbUpCount: number;
  images: string[];
  topicName?: string;
  topicId?: string;
  createTime: string;
  hasThumbUp: boolean;
  thumbUpList: string[];
  vip: boolean;
}


/**
 * 摸鱼评论内容
 */
export interface SubComment {
  id: string;
  userId: string;
  avatar: string;
  position: string;
  company: string;
  nickname: string;
  targetUserId: string;
  targetUserNickname: string;
  targetUserIsVip: boolean;
  createTime: string;
  content: string;
  thumbUpList: string[];
  commentId: string;
  vip: boolean;
}
export interface MoyuComment {
  id: string;
  userId: string;
  company?: string;
  position?: string;
  avatar: string;
  nickname: string;
  createTime: string;
  content: string;
  thumbUpList: string[];
  thumbUp: number;
  momentId: string;
  subComments: SubComment[];
  vip: boolean;
}

/**
 * 所有话题分类
 */
export interface Datum {
  id: string;
  topicName: string;
  cover: string;
  followCount: number;
  contentCount: number;
  hasFollowed: boolean;
  description: string;
}

/**
 * 发表评论所需参数
 */
export interface CommentParam{
  momentId: string
  content: string
}
