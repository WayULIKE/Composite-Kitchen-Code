/*
 * @Desc: 系统API的封装
 * @Author: qincji
 * @Date: 2024/5/25
 */
import { pasteboard } from '@kit.BasicServicesKit'
import { promptAction } from '@kit.ArkUI'

class SysUtil {
  /**
   * 复制到系统剪切板
   * @param content
   */
  copy(content: string) {
    const pasteboardData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, content)
    const systemPasteboard = pasteboard.getSystemPasteboard()
    systemPasteboard.setDataSync(pasteboardData)
    systemPasteboard.getData().then((data) => {
      if (data) {
        promptAction.showToast({ message: '复制成功' })
      } else {
        promptAction.showToast({ message: '复制失败' })
      }
    })
  }
}

export const sysUtil = new SysUtil();
