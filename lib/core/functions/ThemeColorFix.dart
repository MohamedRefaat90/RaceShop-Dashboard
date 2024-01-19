import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color ThemeColorFix() {
  HomeController homeController = Get.find();

  if (homeController.myServices.sharedPreferences.getBool("isDarkMode")!) {
    return AppColors.white;
  } else {
    return AppColors.black;
  }
}
