import 'package:dashboard/controller/Categories/CategoriesController.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/functions/translate.dart';

class CategoriesBar extends GetView<CategoriesController> {
  const CategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProductsControllerImp categoryProductsControllerImp = Get.find();
    HomeController homeController = Get.find();
    return GetBuilder<CategoriesController>(builder: (categoriesController) {
      return SizedBox(
        height: 50,
        child: ListView.builder(
          itemCount: controller.categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => MaterialButton(
            onPressed: () {
              categoriesController.changeCategoryindex(index);

              categoryProductsControllerImp.pageNumber = 1;
              categoryProductsControllerImp.categoryProducts.clear();
              categoryProductsControllerImp.statusRequest =
                  StatusRequest.loading;
              categoryProductsControllerImp.update();
              categoryProductsControllerImp.getCategoryProducts(
                  categoryID: controller
                      .categories[categoriesController.selectedCategoryIndex!]
                      .categoryID,
                  page: categoryProductsControllerImp.pageNumber,
                  sort: "desc",
                  sortBy: "price");
            },
            splashColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translate(controller.categories[index].categoryName!,
                      controller.categories[index].categoryNameAr!),
                  style: TextStyle(
                      color: homeController.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo"),
                ),
                categoriesController.selectedCategoryIndex == index
                    ? Container(
                        margin: const EdgeInsets.only(top: 3),
                        height: 3,
                        width: 25,
                        color: AppColors.secondryColor)
                    : const SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }
}
