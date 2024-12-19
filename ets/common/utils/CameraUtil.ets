
import { cameraPicker as picker, camera} from '@kit.CameraKit';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';





/*本工具类使用方法:
 *
 * 1. 导入本工具类: import { CameraUtil } from './path/to/CameraUtil.ets';
 * 2. 获取当前模块的上下文, 后面要将其作为相机的配置信息: let context = getContext(this) as common.Context;
 * 3. 实例化相机: let cameraUtil = new CameraUtil(context);
 * 4. 调用takePhoto方法来拍照, 此方法会返回照片储存的uri: let photoUri = await cameraUtil.takePhoto();
 *
 * */













export class CameraUtil{


  private context: common.Context;
  constructor(context: common.Context) {
    this.context=context;
  }
  //配置相机用的环境上下文


  async takePhoto(quality: number = 100, width: number = 1080, height: number = 1920): Promise<string | null> {
    //默认参数, 一般不用传参


    try{


      let pickerProfile: picker.PickerProfile={
        cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
      };
      let pickerResult: picker.PickerResult=await picker.pick(
        this.context,
        [picker.PickerMediaType.PHOTO],
        pickerProfile
      )
      //创建并配置, 选择使用后置摄像头

      let photoUri: string|null = pickerResult.resultUri;
      //拍照, 并返回照片的默认储存位置

      if (photoUri!=null) {
        return photoUri;
      }

      return `调用相机失败`;

    } catch (error) {
      let err = error as BusinessError;
      console.error(`Photo capture failed. Error code: ${err.code}`);
      return null;
    }

  }





}

