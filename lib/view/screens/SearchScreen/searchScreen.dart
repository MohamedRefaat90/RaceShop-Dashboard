import 'package:dashboard/controller/CategoryProducts/CategoryProductsController.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/search/searchController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/data/Model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product/ProductController.dart';
import '../../../core/functions/ThemeColorFix.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchBarController searchController = Get.find();
    return GetBuilder<SearchBarController>(
        builder: (controller) => controller.statusRequest ==
                StatusRequest.loading
            ? const SizedBox(
                height: 200,
                child: Center(
                    child: CircularProgressIndicator(
                        color: AppColors.secondryColor)))
            : controller.searchedProducts.isEmpty
                ? Center(
                    child: Text("NoResultsWereFound".tr,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: ThemeColorFix())))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                          children: [
                            TextSpan(text: "ResultsFor:".tr),
                            TextSpan(text: searchController.searchWord),
                          ],
                          style:
                              TextStyle(color: ThemeColorFix(), fontSize: 30))),
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1.2),
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemCount: controller.searchedProducts.length,
                          itemBuilder: (context, index) => SearchItemCard(
                              product: controller.searchedProducts[index],
                              index: index),
                        ),
                      ),
                    ],
                  ));
  }
}

class SearchItemCard extends GetView<SearchBarController> {
  const SearchItemCard({required this.product, required this.index, super.key});
  final productModel product;
  final int index;
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryProductsControllerImp());
    HomeController homeController = Get.find();
    ProductDetailsControllerImp productDetailsController =
        Get.put(ProductDetailsControllerImp());
    return MaterialButton(
      onPressed: () {
        controller.homeController.changePage(11);
        productDetailsController.product = product;
        productDetailsController.productVariationsSize =
            product.productVariationsBySize!.keys.toList();
      },
      color: ThemeColorFix(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(product.productCoverImage, width: 130),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(product.productName,
                  style: TextStyle(
                      color: homeController.isDarkMode
                          ? AppColors.black
                          : AppColors.white)),
              Text("${product.productPrice} LE",
                  style: TextStyle(
                      color: homeController.isDarkMode
                          ? AppColors.black
                          : AppColors.white))
            ],
          )
        ],
      ),
    );
  }
}
