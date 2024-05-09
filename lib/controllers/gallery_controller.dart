import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_photo_gallery/services/remote_services.dart';

import '../models/image_model.dart';

final GalleryController galleryController = Get.put(GalleryController());

class GalleryController extends GetxController {
  var imageList = [].obs;
  var loading = false.obs;

  Future fetchImages(Map<String, dynamic> params) async {
    var images = await RemoteService.fetchImages(params: params).catchError(debugPrint);
    if(images.isNotEmpty) {
      List<ImageModel> _list = List<ImageModel>.from(imageList);
      _list.addAll(images);
      imageList.value = _list;
    }
  }

  void clearImageList() {
    imageList.value = [];
  }
}