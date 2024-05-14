export * as user from './user'

export * as content from './content'

export * as moyu from './moyu'


export interface SunData<T> {
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

export interface SunHeader{

  l_c_i?: string
  cookie?: string


}