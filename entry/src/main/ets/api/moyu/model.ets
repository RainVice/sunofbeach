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
 * 摸鱼动态列表
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