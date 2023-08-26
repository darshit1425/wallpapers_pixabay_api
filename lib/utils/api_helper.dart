import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pixabay_api/screen/pixabay/model/pixabay_model.dart';

class Api_Helper {
  static final Api_Helper helper = Api_Helper._();

  Api_Helper._();

  Future<PixabayModel> GetData(String animal) async {
    String Link =
        "https://pixabay.com/api/?key=27278777-989ed1f6f6b0aad88a9350844&q=$animal&image_type=photo&per_page=50";
    Uri uri = Uri.parse(Link);

    var response = await http.get(uri);
    var json = jsonDecode(response.body);

    print(json);
    PixabayModel pixabayModel = PixabayModel.fromJson(json);

    return pixabayModel;
  }
}
