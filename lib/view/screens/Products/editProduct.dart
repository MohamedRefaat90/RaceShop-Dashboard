import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../controller/product/ProductController.dart';
import '../../../core/class/statusRequest.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/shared/BTN.dart';
import '../../widgets/editProducts/pickProductImages.dart';
import '../../widgets/editProducts/productBasicInfo.dart';
import '../../widgets/editProducts/productsColors.dart';
import '../../widgets/editProducts/productsSizes.dart';
import '../../widgets/editproducts/ColorsandSizes.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    ProductDetailsControllerImp productDetailsController = Get.find();
    return SingleChildScrollView(
        child: GetBuilder<ProductDetailsControllerImp>(builder: (controller) {
      return Form(
          key: controller.editProductFormkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Edit".tr,
                    style: TextStyle(
                        color: homeController.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                TextSpan(
                    text: " ${productDetailsController.product.productName}",
                    style: TextStyle(
                        color: homeController.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30))
              ])),
              const SizedBox(height: 40),
              const productBasicInfo(),
              const SizedBox(height: 50),
              const pickProductImages(),
              const SizedBox(height: 30),
              const ColorsandSizes(),
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
                                : Text("Edit".tr),
                        padding: 30,
                        color: AppColors.secondryColor,
                        width: 150,
                        press: () async {
                          if (controller.editProductFormkey.currentState!
                              .validate()) {
                            print(controller.ProductVariationsSize);
                            controller.editProduct();
                            // await controller.createProduct();
                          }
                        }),
                  ],
                );
              })
            ],
          ));
    }));
  }
}
