import 'package:dashboard/core/constants/AppTheme.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData theme = themeEnglish;

  changeLanguage(String langCode) {
    language = Locale(langCode);
    myServices.sharedPreferences.setString("lang", langCode);
    theme = langCode == 'ar' ? themeArabic : themeEnglish;
    Get.changeTheme(theme);
    Get.updateLocale(language!);
  }

  // for if First Time Open the App .. will Take Device Language
  @override
  void onInit() {
    String? sharedLang = myServices.sharedPreferences.getString('lang');
    if (sharedLang == "ar") {
      language = const Locale('ar');
      theme = themeArabic;
    } else if (sharedLang == 'en') {
      language = const Locale('en');
      theme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
