import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product/ProductController.dart';
import '../../../core/functions/translate.dart';

class productDesc extends GetView<ProductDetailsControllerImp> {
  const productDesc({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Text(
        translate(
            controller.product.productDesc, controller.product.productDescAr),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 16,
            color:
                homeController.isDarkMode ? AppColors.white : AppColors.black));
  }
}
