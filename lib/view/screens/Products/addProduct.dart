import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/core/shared/customField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../widgets/addProducts/pickProductImages.dart';
import '../../widgets/addProducts/productBasicInfo.dart';
import '../../widgets/addProducts/productsColors.dart';
import '../../widgets/addProducts/productsSizes.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return GetBuilder<CategoryProductsControllerImp>(builder: (controller) {
      return SingleChildScrollView(
        child: Form(
          key: controller.addProductFormkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: "AddNewProductTo".tr),
                  TextSpan(
                      text: controller
                          .categoriesController
                          .categories[controller
                              .categoriesController.selectedCategoryIndex!]
                          .categoryName),
                ]),
                style: TextStyle(
                    color: homeController.isDarkMode
                        ? AppColors.white
                        : AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(height: 40),
              const productBasicInfo(),
              const SizedBox(height: 50),
              const pickProductImages(),
              const SizedBox(height: 30),
              const productsSizes(),
              const SizedBox(height: 30),
              const productsColors(),
              const SizedBox(height: 50),
              GetBuilder<CategoryProductsControllerImp>(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BTN(
                        widget:
                            controller.statusRequest == StatusRequest.loading
                                ? const SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                        color: AppColors.white, strokeWidth: 4))
                                : Text("CreateProduct".tr),
                        padding: 30,
                        color: AppColors.secondryColor,
                        width: 300,
                        press: () async {
                          if (controller.addProductFormkey.currentState!
                              .validate()) {
                            await controller.createProduct();
                          }
                        }),
                  ],
                );
              })
            ],
          ),
        ),
      );
    });
  }
}
