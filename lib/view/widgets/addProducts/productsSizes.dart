import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/functions/ThemeColorFix.dart';

class productsSizes extends GetView<CategoryProductsControllerImp> {
  const productsSizes({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return GetBuilder<CategoryProductsControllerImp>(builder: (context) {
      return Row(
        children: [
          Text("Sizes:".tr,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: homeController.isDarkMode
                      ? AppColors.white
                      : AppColors.black)),
          const SizedBox(width: 20),
          ...List.generate(
              controller.sizes.length,
              (index) => InkWell(
                  onTap: () {
                    controller.changeSelectedSize(index);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: controller.selectedSizeIndex == index
                            ? ThemeColorFix()
                            : null,
                        border: Border.all(color: ThemeColorFix(), width: 2)),
                    child: Center(
                      child: Text(
                        "${controller.sizes[index]}",
                        style: TextStyle(
                          color: controller.selectedSizeIndex == index
                              ? homeController.isDarkMode
                                  ? AppColors.black
                                  : AppColors.white
                              : homeController.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )))
        ],
      );
    });
  }
}
