import 'package:dashboard/core/constants/AppAssets.dart';
import 'package:dashboard/core/constants/AppTheme.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/view/screens/CategoriesScreen/CategoriesScreen.dart';
import 'package:dashboard/view/screens/Dashboard/Dashboard.dart';
import 'package:dashboard/view/screens/DeliveryZone/EditZone.dart';
import 'package:dashboard/view/screens/Products/productDetails.dart';
import 'package:dashboard/view/screens/orderDetails/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusRequest.dart';
import '../../core/constants/AppColors.dart';
import '../../data/Model/userModel.dart';
import '../../view/screens/CategoriesScreen/AddCategoryScreen.dart';
import '../../view/screens/CategoriesScreen/EditCategoryScreen.dart';
import '../../view/screens/DeliveryZone/AddZone.dart';
import '../../view/screens/DeliveryZone/DeliveryZoneScreen.dart';
import '../../view/screens/OrdersScreen/OrdersScreen.dart';
import '../../view/screens/Products/addProduct.dart';
import '../../view/screens/Products/editProduct.dart';
import '../../view/screens/SearchScreen/searchScreen.dart';
import '../../view/screens/categoryProductsScreen/categoryProducts.dart';

class HomeController extends GetxController {
  TextEditingController search = TextEditingController();
  int selectedPage = 0;
  bool isDarkMode = false;
  ThemeMode themeMode = ThemeMode.system;
  late userModel? user;
  String? selectedLang = "en";
  Locale? locale = const Locale('en');
  ThemeData? mainTheme = themeEnglish;
  MyServices myServices = Get.find();
  StatusRequest? statusRequest;
  late String userToken;

  List<Map<String, dynamic>> menu = [
    {"title": "dashboard", "icon": AppAssets.chartIcon},
    {"title": "categories", "icon": AppAssets.categories},
    {"title": "Orders", "icon": AppAssets.bag},
    {"title": "dileveryZones", "icon": AppAssets.locationMarker}
  ];
  List<Widget> pages = const [
    /* 0 */ Dashboard(),
    /* 1 */ CategoriesScreen(),
    /* 2 */ OrdersScreen(),
    /* 3 */ DeliveryZoneScreen(),
    /* 4 */ CategoryProducts(),
    /* 5 */ AddCategoryScreen(),
    /* 6 */ EditCategoryScreen(),
    /* 7 */ OrderDetailsScreen(),
    /* 8 */ AddZoneScreen(),
    /* 9 */ EditZoneScreen(),
    /* 10 */ AddProduct(),
    /* 11 */ ProductDetails(),
    /* 12 */ EditProduct(),
    /* 13 */ SearchScreen()
  ];
  @override
  void onInit() {
    user = Get.arguments;
    // isDarkMode = myServices.sharedPreferences.getBool('isDarkMode') ?? false;
    changeLang(myServices.sharedPreferences.getString('lang'));
    changeThemeMode(myServices.sharedPreferences.getBool('isDarkMode')!);
    // getAllCategories();
    super.onInit();
  }

  changeThemeMode(bool value) {
    myServices.sharedPreferences.setBool('isDarkMode', value);
    isDarkMode = myServices.sharedPreferences.getBool('isDarkMode') ?? false;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode);
    Get.updateLocale(locale!);

    update();
  }

  changePage(int index) {
    selectedPage = index;
    update();
  }

  getColorSidebarTial(int index) {
    Color color;
    if (isDarkMode) {
      color = selectedPage == index
          ? const Color.fromARGB(255, 46, 46, 46)
          : AppColors.black;
    } else {
      color = selectedPage == index
          ? const Color.fromARGB(255, 248, 250, 255)
          : AppColors.white;
    }

    return color;
  }

  getColorSidebarTialText(int index) {
    Color color;
    if (isDarkMode) {
      color = selectedPage == index
          ? AppColors.white
          : const Color.fromARGB(255, 128, 124, 124);
    } else {
      color = selectedPage == index
          ? const Color.fromARGB(255, 42, 65, 120)
          : const Color.fromARGB(255, 167, 183, 221);
    }

    return color;
  }

  getColorSidebarTialIcon(int index) {
    Color color;
    if (isDarkMode) {
      color = selectedPage == index
          ? AppColors.white
          : const Color.fromARGB(255, 128, 124, 124);
    } else {
      color = selectedPage == index
          ? const Color.fromARGB(255, 42, 65, 120)
          : const Color.fromARGB(255, 167, 183, 221);
    }

    return color;
  }

  changeLang(String? value) {
    selectedLang = value;

    if (selectedLang == "ar") {
      myServices.sharedPreferences.setString('lang', 'ar');
      locale = Locale(myServices.sharedPreferences.getString('lang')!);
      mainTheme = themeArabic;
      Get.changeTheme(mainTheme!);
      Get.updateLocale(locale!);
    } else {
      myServices.sharedPreferences.setString('lang', 'en');
      locale = Locale(myServices.sharedPreferences.getString('lang')!);
      mainTheme = themeEnglish;
      Get.changeTheme(mainTheme!);
      Get.updateLocale(locale!);
    }
    update();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}
