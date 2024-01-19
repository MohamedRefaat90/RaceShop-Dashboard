import 'dart:convert';
import 'dart:io';

import 'package:dashboard/controller/Login/login.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../../../../ApiLinks.dart';
import '../../../../core/class/DB_helper.dart';

class ProductsData {
  DB_helper db_helper;
  ProductsData(this.db_helper);

  createProduct(
      {required String productName,
      required String productNameAr,
      required String productDesc,
      required String productDescAr,
      required File mainImage,
      required List imageFiles,
      required String categoryID,
      required List variations,
      required int discount,
      required int price,
      required String userToken}) async {
    String fileName = mainImage.path.split('\\').last;
    String mimeType = mime(fileName)!;
    String mimee = mimeType.split('/')[0];
    String type = mimeType.split('/')[1];

    final uploadList = <MultipartFile>[];
    for (final image in imageFiles) {
      String fileName = image.path.split('\\').last;
      String mimeType = mime(fileName)!;
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      uploadList.add(
        await MultipartFile.fromFile(image.path,
            filename: fileName, contentType: MediaType(mimee, type)),
      );
    }

    FormData data = FormData.fromMap({
      "name": productName,
      "name_ar": productNameAr,
      "description": productDesc,
      "description_ar": productDescAr,
      "image": await MultipartFile.fromFile(mainImage.path,
          filename: fileName, contentType: MediaType(mimee, type)),
      "images": uploadList,
      "category": categoryID,
      "variations": jsonEncode(variations),
      "discount": discount,
      "price": price
    });
    print(variations);
    var response =
        await db_helper.postData(ApiLinks.product, data, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  getProduct(String userToken) async {
    var response =
        await db_helper.getAllData(ApiLinks.product, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  updateProduct(
    String productID, {
    required String productName,
    required String productNameAr,
    required String productDesc,
    required String productDescAr,
    required File? mainImage,
    required List imageFiles,
    required List currentImages,
    required String categoryID,
    required List variations,
    required int discount,
    required int price,
    required String userToken,
  }) async {
    String? fileName;
    String? mimeType;
    String? mimee;
    String? type;
    if (mainImage != null) {
      fileName = mainImage.path.split('\\').last;
      mimeType = mime(fileName)!;
      mimee = mimeType.split('/')[0];
      type = mimeType.split('/')[1];
    }

    final uploadList = <MultipartFile>[];
    for (final image in imageFiles) {
      String fileName = image.path.split('\\').last;
      String mimeType = mime(fileName)!;
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];
      uploadList.add(
        await MultipartFile.fromFile(image.path,
            filename: fileName, contentType: MediaType(mimee, type)),
      );
    }
    FormData data = FormData.fromMap({
      "name": productName,
      "name_ar": productNameAr,
      "description": productDesc,
      "description_ar": productDescAr,
      "image": mainImage != null
          ? await MultipartFile.fromFile(mainImage.path,
              filename: fileName, contentType: MediaType(mimee!, type!))
          : '',
      "currentImages": currentImages,
      "images": uploadList,
      "category": categoryID,
      "variations": variations,
      "discount": discount,
      "price": price
    });
    // print(variations);
    var response = await db_helper.patchData(
        "${ApiLinks.product}/$productID", data,
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  deleteProduct(String productID, String userToken) async {
    var response =
        await db_helper.deleteData("${ApiLinks.product}/$productID", userToken);

    return response.fold((l) => l, (r) => r);
  }
}
