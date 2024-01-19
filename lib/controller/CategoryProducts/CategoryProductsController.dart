import 'package:dashboard/controller/Categories/CategoriesController.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppRoutes.dart';
import 'package:dashboard/core/functions/handelDataController.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/data/Model/productModel.dart';
import 'package:dashboard/data/dataSource/remote/CategoryProducts/CategoryProductsData.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';

import '../../data/dataSource/remote/Product/productData.dart';

abstract class CategoryProductsController extends GetxController {
  getCategoryProducts(
      {required String categoryID,
      // double? minPrice,
      // double? maxPrice,
      String? sort,
      String? sortBy,
      int? limit,
      int? page});

  // changeSliderValues({required double lowerValue, required double upperValue});
}

class CategoryProductsControllerImp extends CategoryProductsController {
  StatusRequest statusRequest = StatusRequest.loading;
  HomeController homeController = Get.find();
  CategoriesController categoriesController = Get.find();
  CategoryProductsData categoryProductsData = CategoryProductsData(Get.find());
  ProductsData productsData = ProductsData(Get.find());
  MyServices myServices = Get.find();
  late String userToken;
  List categoryProducts = [];
  File? mainImage;
  List imageFiles = [];
  List colorsName = ['red', 'green', 'blue', 'yellow', 'black', 'white'];
  List sizes = ['S', 'M', 'L', 'XL', 'XXL', null];
  List colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.black,
    Colors.white
  ];
  TextEditingController productName = TextEditingController();
  TextEditingController productNameAr = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  TextEditingController productDescAr = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();

  int? selectedColorIndex;
  int? selectedSizeIndex;
  double textFiledWidth = 250;
  GlobalKey<FormState> addProductFormkey = GlobalKey<FormState>();

  GlobalKey<FormState> quantityFormkey = GlobalKey<FormState>();
  bool showColors = false;
  // int? selectedCategoryIndex;
  List<Map> variations = [];
  bool isVariationAdded = false;
  late ScrollController scrollController;
  late int totalItems;
  late int pageNumber;
  late bool loading;
  final int numOfProductsPerRequest = 30;
  int? totalPages;
  @override
  void onInit() {
    // categoriesList = Get.arguments['categories'];
    // selectedCat = Get.arguments['selectedCategoryIndex'];
    // userToken = myServices.sharedPreferences.getString('userToken')!;
    scrollController = ScrollController();
    pageNumber = 1;
    loading = false;
    userToken = myServices.sharedPreferences.getString('userToken')!;
    scrollController.addListener(pagination);
    super.onInit();
  }

  pagination() {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (pageNumber <= totalPages!)) {
      loading = true;
      pageNumber++;

      getCategoryProducts(
          categoryID: categoriesController
              .categories[categoriesController.selectedCategoryIndex!]
              .categoryID,
          page: pageNumber,
          limit: categoryProducts.length,
          sort: "desc",
          sortBy: "price");

      update();
    }
  }

  @override
  getCategoryProducts(
      {required categoryID,
      minPrice,
      maxPrice,
      sort,
      sortBy,
      page,
      limit}) async {
    categoryProducts.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoryProductsData.getCategoryProductsData(
        categoryID: categoryID,
        sort: sort,
        sortBy: sortBy,
        page: pageNumber,
        limit: numOfProductsPerRequest,
        userToken: userToken);

    statusRequest = handelData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        totalItems = response['data']['totalItems'];
        totalPages = response['data']['totalPages'];

        List products = response['data']['data']
            .map((e) => productModel.formjson(e))
            .toList();
        categoryProducts.addAll(products);
      }
    } else {
      statusRequest =
          categoryProducts.isEmpty ? StatusRequest.failure : StatusRequest.none;
      loading = false;
    }

    update();
  }

  pickMainImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['svg', 'jpg', 'png'], type: FileType.custom);
    if (result != null) {
      mainImage = File(result.files.single.path!);
    }
    update();
  }

  pickproductImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: ['svg', 'jpg', 'png'],
        type: FileType.custom);

    if (result != null) {
      imageFiles = result.paths.map((path) => File(path!)).toList();
    }
    update();
  }

  changeSelectedColor(int value) {
    selectedColorIndex = value;
    update();
  }

  changeSelectedSize(int value) {
    selectedSizeIndex = value;
    showColors = true;
    update();
  }

  createProduct() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await productsData.createProduct(
        categoryID: categoriesController
            .categories[categoriesController.selectedCategoryIndex!].categoryID,
        productName: productName.text,
        productNameAr: productNameAr.text,
        productDesc: productDesc.text,
        productDescAr: productDescAr.text,
        mainImage: mainImage!,
        imageFiles: imageFiles,
        variations: variations,
        discount: int.parse(discount.text),
        price: int.parse(price.text),
        userToken: userToken);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      homeController.changePage(4);
      getCategoryProducts(
          categoryID: categoriesController
              .categories[categoriesController.selectedCategoryIndex!]
              .categoryID,
          page: pageNumber,
          limit: numOfProductsPerRequest,
          sort: "desc",
          sortBy: "price");

      /*  Reset */
      productName.text = '';
      productNameAr.text = '';
      productDesc.text = '';
      productDescAr.text = '';
      price.text = '';
      quantity.text = '';
      discount.text = '';
      imageFiles.clear();
      variations.clear();
      mainImage = null;
    }
  }

  addVariation() {
    variations.add({
      "color": colorsName[selectedColorIndex!],
      "size": sizes[selectedSizeIndex!],
      "quantity": int.parse(quantity.text)
    });
    isVariationAdded = true;
    Future.delayed(const Duration(seconds: 2), () {
      isVariationAdded = false;
      update();
    });
    update();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
