import 'package:dashboard/core/constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snakBar({required message, Color? color, Widget? btn}) {
  return Get.showSnackbar(GetSnackBar(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      borderRadius: 15,
      backgroundColor: color!,
      messageText:
          Text(message, style: TextStyle(fontSize: 16, color: AppColors.white)),
      duration: Duration(seconds: 2),
      mainButton: btn));
}
