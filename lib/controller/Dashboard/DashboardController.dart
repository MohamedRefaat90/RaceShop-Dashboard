import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/AppAssets.dart';

class DashboardController extends GetxController {
  List<Map> staticsCards = [
    {
      "gridientColors": [
        const Color.fromARGB(255, 107, 170, 252),
        const Color.fromARGB(255, 48, 95, 236)
      ],
      "svgPic": AppAssets.shipping,
      "rotateAngle": -50,
      "title": "compeletedOrders".tr
    },
    {
      "gridientColors": [
        const Color.fromARGB(255, 239, 94, 123),
        const Color.fromARGB(255, 211, 83, 132),
      ],
      "svgPic": AppAssets.shopingCar,
      "rotateAngle": -20,
      "title": "pendingOrders".tr
    },
    {
      "gridientColors": [
        const Color.fromARGB(255, 214, 35, 254),
        const Color.fromARGB(255, 164, 48, 242),
      ],
      "svgPic": AppAssets.shopingBag,
      "rotateAngle": 0,
      "title": "totalOrders".tr
    }
  ];
}
