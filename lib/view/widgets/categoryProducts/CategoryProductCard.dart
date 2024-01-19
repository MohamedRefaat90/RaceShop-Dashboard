import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/functions/translate.dart';
import 'package:dashboard/data/Model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../controller/product/ProductController.dart';
import '../../../core/constants/AppColors.dart';

class CategoryProductCard extends GetView<HomeController> {
  const CategoryProductCard(
      {super.key, required this.index, required this.product});

  final productModel product;
  final int index;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    CategoryProductsControllerImp categoryProductsController = Get.find();
    ProductDetailsControllerImp productController =
        Get.put(ProductDetailsControllerImp());
    double size = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        homeController.changePage(11);

        productController.product =
            categoryProductsController.categoryProducts[index];

        productController.productVariationsSize =
            product.productVariationsBySize!.keys.toList();
        productController.editProductVariationsSize =
            Map<dynamic, dynamic>.fromEntries(
                    productController.product.productVariationsBySize!.entries)
                .entries
                .map((e) => {e.key: e.value})
                .toList();

        // for (var e in productController.editProductVariationsSize) {
        //   productController.editKeys.add(e.key);
        //   productController.editValues.add(e.values);
        // }
        // editKeys = productController.editProductVariationsSize.

        // print(x.entries.map((e) => {e.key: e.value}).toList());
        // print(productController.editKeys);
        // print(productController.editValues);
        // print(productController.product.productVariationsBySize!);
        // print(categoryProductsController.variations);
      },
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: CachedNetworkImage(
                    imageUrl: product.productCoverImage,
                    errorWidget: (context, url, error) =>
                        const Center(child: CircularProgressIndicator()),
                    alignment: Alignment.center,
                    height: 120,
                  )),
                  Center(
                    child: Text(
                        translate(product.productName, product.productNameAr),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size * 0.0090)),
                  ),
                  Column(
                    children: [
                      Text("${product.productPrice} LE",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: product.productDiscount > 0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)),
                      if (product.productDiscount > 0)
                        Shimmer.fromColors(
                          baseColor: AppColors.primaryColor,
                          highlightColor: const Color.fromARGB(255, 233, 0, 0),
                          child: Text(
                            "${product.productPrice - (product.productPrice * product.productDiscount ~/ 100).toInt()} LE",
                            style: TextStyle(
                                color: product.productDiscount > 0
                                    ? AppColors.secondryColor
                                    : AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (product.productDiscount > 0)
            Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: size * 0.014,
                  child: Text(
                    "${product.productDiscount}%",
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size * 0.0090),
                  ),
                ))
        ],
      ),
    );
  }
}
