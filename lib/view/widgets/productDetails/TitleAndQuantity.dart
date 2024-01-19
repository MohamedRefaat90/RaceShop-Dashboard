import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/data/Model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/product/ProductController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/functions/translate.dart';
import '../../../data/Model/productModel.dart';
import 'QuantityBTN.dart';
import 'QuantityNumber.dart';

class TitleAndQuantity extends GetView<ProductDetailsControllerImp> {
  const TitleAndQuantity({super.key, required this.product});
  final productModel product;
  @override
  Widget build(BuildContext context) {
    Get.find<ProductDetailsControllerImp>();
    HomeController homeController = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                  translate(controller.product.productName,
                      controller.product.productNameAr),
                  softWrap: true,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 25, height: 1.3, color: ThemeColorFix())),
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     QuantityBTN(
            //         icon: Icons.add,
            //         press: () => controller.upProductQuantity()),
            //     GetBuilder<ProductDetailsControllerImp>(builder: (context) {
            //       return QuantityNumber(count: controller.productQuantity);
            //     }),
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 10),
            //       child: QuantityBTN(
            //           icon: Icons.minimize,
            //           press: () => controller.downProductQuantity()),
            //     ),
            //   ],
            // )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Shimmer.fromColors(
              enabled: product.productDiscount > 0 ? false : true,
              baseColor: ThemeColorFix(),
              highlightColor: const Color.fromARGB(255, 233, 0, 0),
              child: Container(
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //     strokeAlign: 3, color: AppColors.black, width: 2)
                ),
                child: Text("${product.productPrice} LE",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: product.productDiscount > 0
                            ? FontWeight.w400
                            : FontWeight.w900,
                        decoration: product.productDiscount > 0
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              ),
            ),
            const SizedBox(width: 20),
            if (product.productDiscount > 0)
              Shimmer.fromColors(
                baseColor: AppColors.primaryColor,
                highlightColor: const Color.fromARGB(255, 233, 0, 0),
                child: Container(
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //     strokeAlign: 3, color: AppColors.black, width: 2)
                    ),
                    child: Text(
                      "${product.productPrice - (product.productPrice * product.productDiscount ~/ 100).toInt()} LE",
                      style: TextStyle(
                          color: product.productDiscount > 0
                              ? AppColors.secondryColor
                              : AppColors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
              ),
          ],
        )
      ],
    );
  }
}
