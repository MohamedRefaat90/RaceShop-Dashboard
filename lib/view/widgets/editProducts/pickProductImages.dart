import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../controller/product/ProductController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/shared/BTN.dart';

class pickProductImages extends GetView<ProductDetailsControllerImp> {
  const pickProductImages({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return GetBuilder<ProductDetailsControllerImp>(builder: (context) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            BTN(
                widget: Text("MainImage".tr),
                press: () => controller.pickMainImage()),
            const SizedBox(width: 50),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: homeController.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                      width: 2)),
              child: Center(
                child: controller.mainImage == null
                    ? Image.network(controller.product.productCoverImage,
                        width: 150)
                    : Image.file(controller.mainImage!, width: 150),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(mainAxisSize: MainAxisSize.min, children: [
          BTN(
              widget: Text("OtherImages".tr),
              press: () => controller.pickproductImages()),
          const SizedBox(width: 83),
          controller.product.productImages.isEmpty
              ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: homeController.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                          width: 2)),
                  child: Center(
                      child: Text("ImagePreview".tr,
                          style: TextStyle(
                              color: homeController.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black))))
              : SizedBox(
                  height: 150,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.imageFiles.isEmpty
                          ? controller.product.productImages.length
                          : controller.imageFiles.length,
                      itemBuilder: (_, index) => Container(
                          width: 150,
                          // height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: homeController.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  width: 2)),
                          child: Center(
                              child: controller.imageFiles.isEmpty
                                  ? Image.network(
                                      controller.product.productImages[index],
                                      width: 150)
                                  : Image.file(controller.imageFiles[index],
                                      width: 150))),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10)))
        ])
      ]);
    });
  }
}
