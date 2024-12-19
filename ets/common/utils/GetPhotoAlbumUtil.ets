// PictureSaving.ets
import { picker } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';


/*使用方法:
 *1. 导包: import PhotoPickerUtil from './PhotoPickerUtil';
 *2. 创建对象:  const photoPicker = new PhotoPickerUtil();
 *3. 调用方法并获取所选图片的uri: const photoUri = await photoPicker.photoPickerGetUri();
 *
 *
 * */


let uris: Array<string> = [];


export async function photoPickerGetUri(): Promise<string|null> {
  try {
    let PhotoSelectOptions = new picker.PhotoSelectOptions();
    PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
    PhotoSelectOptions.maxSelectNumber = 1;
    let photoPicker = new picker.PhotoViewPicker();
    await photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: picker.PhotoSelectResult) => {
       uris = PhotoSelectResult.photoUris;
    }).catch((err: BusinessError) => {
      console.error(`Photo capture failed. Error code: ${err.code}`);
    });
  } catch (error) {
    let err = error as BusinessError;
    console.error(`Photo capture failed. Error code: ${err.code}`);
    return null;
  }
  return uris[0].toString();

}




