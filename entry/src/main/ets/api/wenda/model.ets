/** 问答列表 */
export interface WenDaList {
  id: string;
  title: string;
  userId: string;
  avatar: string;
  nickname: string;
  answerCount: number;
  label: null;
  createTime: string;
  isResolve: string;
  viewCount: number;
  thumbUp: number;
  sob: number;
  categoryId: string;
  categoryName: string;
  isVip: string;
  state: null;
  labels: string[];
}

/**
 * 问答详情
 */
export interface WenDaDetail {
  id: string;
  title: string;
  userId: string;
  avatar: string;
  nickname: string;
  description: string;
  answerCount: number;
  isVip: string;
  createTime: string;
  isResolve: string;
  viewCount: number;
  thumbUp: number;
  sob: number;
  categoryId: string;
  categoryName: string;
  labels: string[];
}


/**
 * 答案列表
 */
export interface WendaComment {
  _id: string
  wendaId: string
  thumbUp: number
  bestAs: string
  content: string
  nickname: string
  avatar: string
  uid: string
  subCommentCount: number
  publishTime: string
  publishTimeText: string
  thumbUps: string[]
  wendaSubComments: WendaSubComment[]
  isVip: boolean
}

export interface WendaSubComment {
  _id: string
  parentId: string
  wendaId: string
  beUid: string
  beNickname: string
  content: string
  publishTime: string
  yourUid: string
  yourAvatar: string
  yourNickname: string
  isVip: boolean
  yourRole?: string
}


