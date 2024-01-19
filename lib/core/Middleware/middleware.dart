import 'package:dashboard/core/constants/AppRoutes.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class Middleware extends GetMiddleware {
  @override
  int? get priority => 0;
  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getBool("isFirstTime") == false) {
      // return const RouteSettings(name: AppRoutes.login);
      // return const RouteSettings(name: AppRoutes.home);
    }
    return super.redirect(route);
  }
}
