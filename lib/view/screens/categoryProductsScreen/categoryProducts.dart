import 'package:dashboard/controller/CategoryProducts/CategoryProductsController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/shared/BTN.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/categoryProducts/Products.dart';

class CategoryProducts extends GetView<CategoryProductsControllerImp> {
  const CategoryProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryProductsControllerImp());

    return GetBuilder<CategoryProductsControllerImp>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70).copyWith(top: 10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // const CategoriesBar(),
          // const Filters(),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                "${controller.categoriesController.categories[controller.categoriesController.selectedCategoryIndex!].categoryName} Category",
                style: TextStyle(
                    color: controller.homeController.isDarkMode
                        ? AppColors.white
                        : AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            BTN(
                widget: Text('AddProduct'.tr),
                press: () => controller.homeController.changePage(10))
          ]),
          const SizedBox(height: 30),
          Expanded(
              child: ListView(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  children: [
                const Products(),
                (controller.loading == true &&
                        controller.statusRequest != StatusRequest.none)
                    ? const SizedBox(
                        height: 60,
                        child: Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor)))
                    : controller.statusRequest == StatusRequest.none
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                                child: Text("NoMoreProducts".tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))))
                        : const SizedBox()
              ]))
        ]),
      );
    });
  }
}
