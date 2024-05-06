import { window } from '@kit.ArkUI'

/**
 * 启用全屏
 */
export const enableFullScreen = async () => {
  const windowClass:window.Window = await window.getLastWindow(getContext())
  windowClass.setWindowLayoutFullScreen(true)
  windowClass.setWindowSystemBarEnable([])
}

/**
 * 禁用全屏
 */
export const disableFullScreen = async () => {
  const windowClass:window.Window = await window.getLastWindow(getContext())
  windowClass.setWindowLayoutFullScreen(false)
  windowClass.setWindowSystemBarEnable(["status","navigation"])
}