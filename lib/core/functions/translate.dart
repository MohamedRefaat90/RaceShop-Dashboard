import 'package:dashboard/core/services/myServices.dart';
import 'package:get/get.dart';

String translate(String enName, String arName) {
  MyServices myServices = Get.find();

  String appLang = myServices.sharedPreferences.getString('lang') ?? "en";

  if (appLang == 'ar') {
    return arName;
  } else {
    return enName;
  }
}
