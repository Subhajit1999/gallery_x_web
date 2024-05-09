import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_photo_gallery/config.dart';

import '../models/image_model.dart';

class RemoteService {
  static var client = http.Client();

  static Future<List<ImageModel>> fetchImages({required Map<String, dynamic> params}) async {
    params['key'] = AUTH_KEY;
    String _q = List<String>.from(params.keys.map((key) => "$key=${params[key]}").toList()).join('&');
    print("$BASE_URL?$_q");

    var response = await client.get(Uri.parse("$BASE_URL?$_q"));
    if(response.statusCode == 200) {
      return List<ImageModel>.from(jsonDecode(response.body)['hits'].map((e) => ImageModel.fromJson(e)).toList());
    }else {
      return [];
    }
  }
}