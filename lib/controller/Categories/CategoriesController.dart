import 'dart:io';
import 'dart:math';

import 'package:dashboard/core/services/myServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/functions/handelDataController.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/data/Model/CategoriesModel.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/functions/UrlToFile.dart';
import '../../data/dataSource/remote/Category/CatrgoriesData.dart';

class CategoriesController extends GetxController {
  StatusRequest? statusRequest;
  CategoriesData categoriesData = CategoriesData(Get.find());
  List categories = [];
  List categoriesSales = [];
  int? selectedCategoryIndex;
  HomeController homeController = Get.find();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  late TextEditingController editName;
  late TextEditingController editNameAr;
  PlatformFile? image;
  File? imageFile;
  String? imgUpload;
  dynamic editedImageFile;

  int? editCategoryIndex;
  String? imageName;
  MyServices myServices = Get.find();
  late String userToken;
  @override
  void onInit() {
    userToken = myServices.sharedPreferences.getString('userToken')!;
    getAllCategories();
    super.onInit();
  }

/* mohamedrefaat900@gmail.com */
  getAllCategories() async {
    statusRequest = StatusRequest.loading;
    update();
    categories.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await categoriesData.getCategories();

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        categories.addAll(response['data']['data']
            .map((e) => CategoriesModel.fromJson(e))
            .toList());
      }
    }
    update();
  }

  changeCategoryindex(int index) {
    selectedCategoryIndex = index;
    update();
  }

  pickCategoryImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['svg'], type: FileType.custom);
    // image = await ImagePickerWeb.getImageAsWidget();
    if (result != null) {
      image = result.files.first;
      // imgUpload = image!.path;
      // final tempDir = await getApplicationDocumentsDirectory();

      // imageFile = File('${tempDir.path}/img${Random().nextInt(5)}');
      // await imageFile!.writeAsBytes(image.bytes);
      File createFileFromBytes(Uint8List bytes) => File.fromRawPath(bytes);
      imageFile = createFileFromBytes(image!.bytes!);
    }

    update();
  }

  createCategories() async {
    // print(imgUpload);
    statusRequest = StatusRequest.loading;
    update();

    if (name.text.isNotEmpty && nameAr.text.isNotEmpty && imageFile != null) {
      var response = await categoriesData.createCategories(
          name: name.text,
          nameAr: nameAr.text,
          image: image!,
          userToken: userToken);
      statusRequest = handelData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          homeController.selectedPage = 1;
          name.clear();
          nameAr.clear();
          homeController.update();
        }
      }
    } else {
      statusRequest = StatusRequest.none;
      update();
    }
  }

  deleteCategory(String categoryID) {
    Get.defaultDialog(
        title: "Warrning".tr,
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_rounded, color: Colors.amber, size: 40),
            Text("DeleteCategory".tr),
          ],
        ),
        confirm: BTN(
            widget: Text("Confirm".tr),
            padding: 20,
            color: Colors.green,
            press: () {
              categoriesData.deleteCategory(categoryID, userToken);
              categories.removeWhere((e) => e.categoryID == categoryID);
              Get.back();
              update();
            }),
        cancel: BTN(
            widget: Text("Cancel".tr),
            color: Colors.red,
            press: () => Get.back()));
  }

  updateCategory(String categoryID) async {
    statusRequest = StatusRequest.loading;
    update();

    editedImageFile =
        await urlToFile(categories[editCategoryIndex!].categoryImage);
    var response = await categoriesData.updateCategories(
        categoryID: categoryID,
        name: editName.text,
        nameAr: editNameAr.text,
        image: image ?? editedImageFile!,
        userToken: userToken);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        homeController.selectedPage = 1;
        name.clear();
        nameAr.clear();
        image = null;
        editedImageFile = File('');
        homeController.update();
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    nameAr.dispose();
    super.dispose();
  }
}
