import 'dart:io';

import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/data/dataSource/remote/Product/productData.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/handelDataController.dart';
import '../../data/Model/productModel.dart';
import '../Categories/CategoriesController.dart';
import '../CategoryProducts/CategoryProductsController.dart';

abstract class ProductDetailsController extends GetxController {
  // upProductQuantity();
  // downProductQuantity();
  changeImageSliderIndicator(int index);
  changeSelectedProductColor(String ColorName, int Sizeindex);
  // productAddtoFav(productID);
}

class ProductDetailsControllerImp extends ProductDetailsController {
  late productModel product;
  late int? productIndex;
  int productQuantity = 1;
  int imagesSliderIndicator = 0;
  String selectedProductColor = "";
  int selectedProductSize = 0;
  MyServices myServices = Get.find();
  late String lang;
  late List productVariationsSize;
  List editProductVariationsSize = [];
  List ProductVariationsSize = [];
  bool isFav = true;
  StatusRequest? statusRequest;
  TextEditingController editproductName = TextEditingController();
  TextEditingController editproductNameAr = TextEditingController();
  TextEditingController editproductDesc = TextEditingController();
  TextEditingController editproductDescAr = TextEditingController();
  TextEditingController editquantity = TextEditingController();
  TextEditingController editprice = TextEditingController();
  TextEditingController editdiscount = TextEditingController();
  double textFiledWidth = 250;
  GlobalKey<FormState> editProductFormkey = GlobalKey<FormState>();
  ProductsData productsData = ProductsData(Get.find());
  CategoryProductsControllerImp categoryProductsController = Get.find();
  CategoriesController categoriesController = Get.find();
  HomeController homeController = Get.find();
  File? mainImage;
  List imageFiles = [];
  List colorsName = ['red', 'green', 'blue', 'yellow', 'black', 'white'];
  List sizes = ['S', 'M', 'L', 'XL', 'XXL', "noSize"];
  var editKeys = [];
  var editValues = [];
  int? selectedColorIndex;
  int? selectedSizeIndex;
  GlobalKey<FormState> quantityFormkey = GlobalKey<FormState>();
  Map productColors = {
    "black": Colors.black,
    "white": Colors.white,
    "red": Colors.red,
    "blue": Colors.blue,
    "green": Colors.green,
    "yellow": Colors.yellow
  };
  List colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.black,
    Colors.white,
  ];
  bool showColors = false;
  bool isVariationAdded = false;
  late String userToken;
  @override
  void onInit() {
    // product = Get.arguments['product'];
    // productIndex = Get.arguments['index'];
    // lang = myServices.sharedPreferences.getString('lang')!;
    userToken = myServices.sharedPreferences.getString('userToken')!;
    super.onInit();
  }

  // @override
  // upProductQuantity() {
  //   productQuantity++;
  //   update();
  // }

  // @override
  // downProductQuantity() {
  //   if (productQuantity > 1) {
  //     productQuantity--;
  //     update();
  //   }
  // }

  @override
  changeImageSliderIndicator(index) {
    imagesSliderIndicator = index;
    update();
  }

  @override
  changeSelectedProductColor(ColorName, Sizeindex) {
    selectedProductColor = ColorName;
    selectedProductSize = Sizeindex;
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

  editVariation() {
    var newSize = false;
    var xx = List.from(editProductVariationsSize);

    for (var e in editProductVariationsSize) {
      // this mean that this Size is Avalible
      if (sizes[selectedSizeIndex!] == e.keys.elementAt(0)) {
        e.values.elementAt(0).add({
          "color": colorsName[selectedColorIndex!],
          "quantity": int.parse(editquantity.text)
        });
        newSize = false;
        isVariationAdded = true;
        Future.delayed(const Duration(seconds: 1), () {
          isVariationAdded = false;
        });
        update();
      } else {
        newSize = true;
      }
    }
    // this is New Size will Add
    if (newSize) {
      editProductVariationsSize.add({
        sizes[selectedSizeIndex!]: [
          {
            "color": colorsName[selectedColorIndex!],
            "quantity": int.parse(editquantity.text)
          }
        ]
      });

      isVariationAdded = true;
      newSize = false;
      Future.delayed(const Duration(seconds: 1), () {
        isVariationAdded = false;
      });
      update();
    }
  }

  // for Add product Screen
  addVariation() {
    ProductVariationsSize.add({
      "color": colorsName[selectedColorIndex!],
      "size": sizes[selectedSizeIndex!],
      "quantity": int.parse(editquantity.text)
    });
    isVariationAdded = true;
    Future.delayed(const Duration(seconds: 1), () {
      isVariationAdded = false;
      update();
    });
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

  editProduct() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await productsData.updateProduct(product.productID,
        categoryID: categoriesController
            .categories[categoriesController.selectedCategoryIndex!].categoryID,
        productName: editproductName.text,
        productNameAr: editproductNameAr.text,
        productDesc: editproductDesc.text,
        productDescAr: editproductDescAr.text,
        currentImages: product.productImages,
        mainImage: mainImage,
        imageFiles: imageFiles,
        variations: ProductVariationsSize,
        discount: int.parse(editdiscount.text),
        price: int.parse(editprice.text),
        userToken: userToken);

    statusRequest = handelData(response);
    // print(product.categoryID);
    if (statusRequest == StatusRequest.success) {
      homeController.changePage(4);
      categoryProductsController.getCategoryProducts(
          categoryID: categoriesController
              .categories[categoriesController.selectedCategoryIndex!]
              .categoryID,
          page: categoryProductsController.pageNumber,
          limit: categoryProductsController.numOfProductsPerRequest,
          sort: "desc",
          sortBy: "price");

      /* Reset */
      mainImage = null;
      imageFiles.clear();
      ProductVariationsSize.clear();
      editProductVariationsSize.clear();
    }
  }

  deleteProduct(String productID) {
    Get.defaultDialog(
        title: 'Warring'.tr,
        contentPadding: const EdgeInsets.all(20),
        titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        content: Text("DeleteProduct".tr),
        confirm: BTN(
            widget: Text('Confirm'.tr),
            width: 100,
            color: Colors.red,
            press: () {
              productsData.deleteProduct(productID, userToken);
              categoryProductsController.categoryProducts
                  .removeWhere((e) => e.productID == productID);
              Get.back();
              homeController.changePage(4);
            }),
        cancel: BTN(
            widget: Text("Cancel".tr),
            color:
                homeController.isDarkMode ? AppColors.white : AppColors.black,
            width: 100,
            press: () => Get.back()));
  }
}
