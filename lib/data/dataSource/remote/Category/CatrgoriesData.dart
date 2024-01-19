import 'package:file_picker/file_picker.dart';
import 'package:universal_io/io.dart';

import 'package:dashboard/ApiLinks.dart';
import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/core/class/DB_helper.dart';
import 'package:dio/dio.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class CategoriesData {
  DB_helper db_helper;
  CategoriesData(this.db_helper);

  getCategories() async {
    var response = await db_helper.getAllData(ApiLinks.category);

    return response.fold((l) => l, (r) => r);
  }

  deleteCategory(String categoryID, String userToken) {
    var response =
        db_helper.deleteData("${ApiLinks.category}/$categoryID", userToken);

    // return response.fold((l) => l, (r) => r);
  }

  createCategories(
      {required String name,
      required String nameAr,
      required PlatformFile image,
      required String userToken}) async {
    // String fileName = image.path!.split('\\').last;
    // String? mimeType = mime(fileName);
    // String mimee = mimeType!.split('/')[0];
    // String type = mimeType.split('/')[1];
    // print(name);
    // print(nameAr);
    // print(image);
    FormData data = FormData.fromMap({
      "name": name,
      "name_ar": nameAr,
      'image': MultipartFile.fromBytes(image.bytes!),
    });

    var response =
        await db_helper.postData(ApiLinks.category, data, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  updateCategories(
      {required String categoryID,
      required String name,
      required String nameAr,
      required File image,
      required String userToken}) async {
    String fileName = image.path.split('\\').last;
    String? mimeType = mime(fileName);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];

    FormData data = FormData.fromMap({
      "name": name,
      "name_ar": nameAr,
      'image': await MultipartFile.fromFile(image.path,
          filename: fileName, contentType: MediaType(mimee, type)),
    });

    var response = await db_helper.patchData(
        "${ApiLinks.category}/$categoryID", data,
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }
}
