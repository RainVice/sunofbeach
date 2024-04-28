export * as user from './user'
export * as ct from './ct'
export * as moyu from './moyu'




export interface SunData<T>{
  success: boolean;
  code: number;
  message: string;
  data: T;
}