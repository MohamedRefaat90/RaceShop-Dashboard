import 'dart:io';

import 'package:dashboard/core/shared/BTN.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/BTN.dart';

AlertExitApp() {
  Get.defaultDialog(
      title: "alertTitle".tr,
      content: Text('alertDesc'.tr),
      actions: [
        BTN(
            widget: Text('yes'.tr),
            width: 80,
            color: Colors.red,
            press: () {
              exit(0);
            }),
        BTN(
            widget: Text('no'.tr),
            width: 80,
            color: Colors.green,
            press: () {
              Get.back();
            })
      ]);
}
