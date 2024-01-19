import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/controller/Categories/CategoriesController.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/core/functions/translate.dart';

import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/core/shared/HandleingRequsetData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../core/class/statusRequest.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    CategoryProductsControllerImp categoryProductsControllerImp =
        Get.put(CategoryProductsControllerImp());

    // for remove the previous image for EditCategoryScreen
    controller.image = null;
    // controller.getAllCategories();
    return GetBuilder<CategoriesController>(builder: (controller) {
      return HandleingRequsetData(
        statusRequest: controller.statusRequest!,
        widget: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('categories'.tr,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: homeController.isDarkMode
                            ? AppColors.white
                            : AppColors.black)),
                BTN(
                  press: () => homeController.changePage(5),
                  width: 130,
                  padding: 12,
                  color: homeController.isDarkMode
                      ? AppColors.white
                      : AppColors.black,
                  widget: Text("add".tr,
                      style: TextStyle(
                          color: homeController.isDarkMode
                              ? AppColors.black
                              : AppColors.white,
                          fontSize: 18)),
                )
              ],
            ),
            const SizedBox(height: 30),
            ...List.generate(
                controller.categories.length,
                (index) => Card(
                      child: ListTile(
                        onTap: () {
                          homeController.changePage(4);
                          controller.changeCategoryindex(index);
                          categoryProductsControllerImp.pageNumber = 1;
                          categoryProductsControllerImp.categoryProducts
                              .clear();
                          categoryProductsControllerImp.statusRequest =
                              StatusRequest.loading;
                          categoryProductsControllerImp.update();
                          categoryProductsControllerImp.getCategoryProducts(
                              categoryID: controller
                                  .categories[controller.selectedCategoryIndex!]
                                  .categoryID,
                              page: categoryProductsControllerImp.pageNumber,
                              sort: "desc",
                              sortBy: "price");
                        },
                        tileColor: homeController.isDarkMode
                            ? const Color.fromARGB(231, 36, 34, 42)
                            : const Color.fromARGB(255, 244, 241, 248),
                        contentPadding: const EdgeInsets.all(10),
                        leading: SvgPicture.network(
                            controller.categories[index].categoryImage,
                            color: ThemeColorFix(),
                            width: 50),
                        title: Text(
                            translate(controller.categories[index].categoryName,
                                controller.categories[index].categoryNameAr),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: homeController.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black)),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              onPressed: () {
                                // go to Category Products
                                homeController.changePage(6);
                                controller.editCategoryIndex = index;

                                controller.editName = TextEditingController(
                                    text: controller
                                        .categories[index].categoryName);
                                controller.editNameAr = TextEditingController(
                                    text: controller
                                        .categories[index].categoryNameAr);
                                controller.imageName = controller
                                    .categories[controller.editCategoryIndex!]
                                    .categoryImage
                                    .split('/')
                                    .last;
                                controller.update();
                              },
                              icon: const Icon(Icons.edit,
                                  color: Colors.purpleAccent)),
                          const SizedBox(width: 10),
                          IconButton(
                              onPressed: () => controller.deleteCategory(
                                  controller.categories[index].categoryID),
                              icon: const Icon(Icons.delete_rounded,
                                  color: Colors.red))
                        ]),
                      ),
                    ))
          ],
        ),
      );
    });
  }
}
