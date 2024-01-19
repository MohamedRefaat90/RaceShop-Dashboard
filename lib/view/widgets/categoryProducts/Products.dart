import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';

import '../../../core/shared/HandleingRequsetData.dart';
import 'CategoryProductCard.dart';

class Products extends GetView<CategoryProductsControllerImp> {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductsControllerImp>(builder: (controller) {
      return HandleingRequsetData(
          statusRequest: controller.statusRequest,
          widget: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.8),
              itemCount: controller.categoryProducts.length,
              itemBuilder: (context, index) {
                return CategoryProductCard(
                    index: index, product: controller.categoryProducts[index]);
              }));
    });
  }
}
