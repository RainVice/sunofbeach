import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { UserAuthentication } from '../utils';
import { webview } from '@kit.ArkWeb';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // webview.WebviewController.initializeWebEngine()
  }

  onDestroy(): void {
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // 初始化持久化储存
    await UserAuthentication.init(this.context)
    await windowStage.loadContent('pages/Index/Index');
  }

  onWindowStageDestroy(): void {
  }

  onForeground(): void {
  }

  onBackground(): void {
  }
}
