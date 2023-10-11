import 'package:daystodieutils/module/entity/upload_image_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class UploadUtils {
  static final _picker = ImagePickerPlugin();

  static Future<String?> uploadImage(
    String itemName, {
    bool needToken = true,
  }) async {
    var xFile = await _picker.getImageFromSource(source: ImageSource.gallery);
    if (xFile == null) {
      return Future.value(null);
    }
    var name = xFile.name;
    var suffix = name.substring(name.lastIndexOf("."));
    var bytes = await xFile.readAsBytes();
    var fileName = "$itemName$suffix";

    var file = MultipartFile.fromBytes(bytes.toList(), filename: fileName);
    var respMap = await NHttpRequest.uploadImage(fileName, file, needToken: needToken);
    var resp = NRespFactory.parseObject(respMap, UploadImageResp());
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      var url = resp.data?.url;
      if (url == null) {
        Get.context?.showMessageDialog("图片地址为空");
        return Future.value(null);
      } else {
        return Future.value(url);
      }
    } else {
      Get.context?.showMessageDialog(resp.message!);
      return Future.value(null);
    }
  }
}
