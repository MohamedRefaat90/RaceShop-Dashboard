import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/functions/handelDataController.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/data/Model/productModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/constants/AppRoutes.dart';
import '../../data/dataSource/remote/Search/SearchData.dart';

class SearchBarController extends GetxController {
  bool isSearch = false;
  SearchData searchData = SearchData(Get.find());
  MyServices myServices = Get.find();
  late String userToken;
  StatusRequest? statusRequest;
  List searchedProducts = [];
  String searchWord = '';
  late TextEditingController searchController;
  HomeController homeController = Get.find();
  @override
  void onInit() {
    userToken = myServices.sharedPreferences.getString('userToken')!;
    searchController = TextEditingController();
    super.onInit();
  }

  checkSearch(bool searchIsEmpty) {
    if (searchIsEmpty == true) {
      isSearch = false;
    }
    update();
  }

  isSearching() {
    isSearch = true;
    homeController.changePage(13);
    update();
  }

  getSearchedData({required String searchedWord}) async {
    searchedProducts.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await searchData.getSearchedData(userToken, searchedWord: searchedWord);

    statusRequest = handelData(response);
    print("==================> $statusRequest");
    searchWord = searchController.text;
    if (statusRequest == StatusRequest.success) {
      searchedProducts = response.value['data']['data']
          .map((e) => productModel.formjson(e))
          .toList();
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  clearSearch() {
    searchController.clear();
    isSearch = false;
    update();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
