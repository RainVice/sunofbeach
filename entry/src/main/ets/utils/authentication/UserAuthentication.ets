import { bundleManager, Context } from '@kit.AbilityKit'
import { distributedKVStore } from '@kit.ArkData';
import { user } from '../../api';

export class UserAuthentication {
  private static context: Context | undefined = undefined
  private static kvStore: distributedKVStore.SingleKVStore | undefined = undefined

  /**
   * 初始化
   * @param context 应用上下文
   */
  static async init(context: Context) {
    UserAuthentication.context = context
    await UserAuthentication.initKVStore()
    await UserAuthentication.initUserInfo()
  }
  /**
   * 初始化数据库
   */
  private static async initKVStore() {
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: UserAuthentication.context!,
      bundleName: bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT).name
    };
    UserAuthentication.kvStore = await distributedKVStore.createKVManager(kvManagerConfig)
      .getKVStore<distributedKVStore.SingleKVStore>("UserAuthentication", {
        securityLevel: distributedKVStore.SecurityLevel.S1,
        kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
      });
  }

  /**
   * 初始化用户信息
   */
  static async initUserInfo() {
    const userId = await UserAuthentication.getUserId()
    if (userId) {
      const userInfo = await user.user_info(userId)
      AppStorage.setOrCreate("userInfo", userInfo)
    }
  }


  /**
   * 设置 token
   * @param token
   */
  static async setToken(token: string) {
    await UserAuthentication.kvStore?.put("token", token)
  }

  /**
   * 读取 token
   * @returns
   */
  static async getToken(): Promise<string> {
    try {
      return (await UserAuthentication.kvStore?.get("token")) as string
    } catch (err) {
      return ''
    }
  }

  /**
   * 设置 userId
   * @param userId
   */
  static async setUserId(userId: string) {
    await UserAuthentication.kvStore?.put('userId', userId)
  }

  /**
   * 读取 userId
   * @returns
   */
  static async getUserId(): Promise<string> {
    try {
      return (await UserAuthentication.kvStore?.get("userId")) as string
    } catch (err) {
      return ''
    }
  }

  static async isLogin(): Promise<boolean>{
    return !!await UserAuthentication.getToken()
  }
}