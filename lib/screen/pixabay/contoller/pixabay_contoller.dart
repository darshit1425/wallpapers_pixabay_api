import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_api/screen/pixabay/model/pixabay_model.dart';
import 'package:pixabay_api/utils/api_helper.dart';

class PixabayContoller extends GetxController {
  RxString animal = "animal".obs;
  TextEditingController txtanimal = TextEditingController();
  Future<PixabayModel> Call(String animal) async {
    PixabayModel model = await Api_Helper.helper.GetData(animal);
    return model;
  }
}
