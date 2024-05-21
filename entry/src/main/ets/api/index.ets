export * as user from './user'

export * as content from './content'

export * as moyu from './moyu'

export * as wenda from './wenda'


export interface SobData<T> {
  success: boolean;
  code: number;
  message: string;
  data: T;
}

export interface ListInfo<T> {

  list: T[]
  total: number
  pageSize: number
  currentPage: number
  hasNext: boolean
  hasPre: boolean
  totalPage: number

}

@Observed
export class ListInfoModel<T> implements ListInfo<T> {
  list: T[] = [];
  total: number = 0;
  pageSize: number = 0;
  currentPage: number = 0;
  hasNext: boolean = false;
  hasPre: boolean = false;
  totalPage: number = 0;
}

export interface SobHeader {

  l_c_i?: string
  cookie?: string


}