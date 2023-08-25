import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_api/screen/pixabay/view/pixabay_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(


          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(
              name: '/',
              page: () => PixabayScreen(),
            ),
          ],
        );
      },
    ),
  );
}
