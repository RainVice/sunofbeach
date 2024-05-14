import { bundleManager, Context } from '@kit.AbilityKit'
import { distributedKVStore } from '@kit.ArkData';

export class UserAuthentication {
  private static context: Context | undefined = undefined
  private static kvStore: distributedKVStore.SingleKVStore | undefined = undefined

  private static async initKVStore(){
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: UserAuthentication.context!,
      bundleName: bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT).name
    };
    UserAuthentication.kvStore = await distributedKVStore.createKVManager(kvManagerConfig).getKVStore<distributedKVStore.SingleKVStore>("UserAuthentication",{
      securityLevel: distributedKVStore.SecurityLevel.S1,
      kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
    });
  }

  static async init(context: Context) {
    UserAuthentication.context = context
    await UserAuthentication.initKVStore()
  }

  static async setToken(token: string){
    await UserAuthentication.kvStore?.put("token",token)
  }

  static async getToken(): Promise<string>{
    try {
      return (await UserAuthentication.kvStore?.get("token")) as string
    } catch (err) {
      return ''
    }
  }

}