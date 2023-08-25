import 'package:get/get.dart';
import 'package:pixabay_api/screen/pixabay/model/pixabay_model.dart';
import 'package:pixabay_api/utils/api_helper.dart';

class PixabayContoller extends GetxController {
  Future<PixabayModel> Call() async {
    PixabayModel model = await Api_Helper.helper.GetData();
    return model;
  }
}
