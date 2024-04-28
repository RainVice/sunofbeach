/**
 * 获取话题列表
 */
export interface TopicIndex {
  id: string;
  topicName: string;
  followCount: number;
  contentCount: number;
  cover?: string | null;
  order: number;
  description?: string | null;
  createTime?: string | null;
  updateTime?: string | null;
}