import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/product/ProductController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/flushBar.dart';

import 'package:dashboard/core/shared/BTN.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/search/searchController.dart';
import '../../widgets/productDetails/ColorsandSizes.dart';
import '../../widgets/productDetails/TitleAndQuantity.dart';
import '../../widgets/productDetails/imageSlider.dart';
import '../../widgets/productDetails/productDesc.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductDetailsControllerImp(), fenix: true);
    HomeController homeController = Get.find();
    SearchBarController searchBarController = Get.find();
    return GetBuilder<ProductDetailsControllerImp>(builder: (controller) {
      return SafeArea(
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  // color:
                  //     const Color.fromARGB(106, 221, 221, 221).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      BTN(
                          widget: const Icon(Icons.arrow_back),
                          width: 50,
                          press: () {
                            searchBarController.isSearch
                                ? homeController.changePage(13)
                                : homeController.changePage(4);
                          }),
                      const Spacer(),
                      BTN(
                          widget: Text('Edit'.tr),
                          color: Colors.purple,
                          width: 100,
                          press: () {
                            homeController.changePage(12);
                            controller.editproductName.text =
                                controller.product.productName;
                            controller.editproductNameAr.text =
                                controller.product.productNameAr;
                            controller.editproductDesc.text =
                                controller.product.productDesc;
                            controller.editproductDescAr.text =
                                controller.product.productDescAr;
                            controller.editprice.text =
                                controller.product.productPrice.toString();
                            controller.editdiscount.text =
                                controller.product.productDiscount.toString();
                          }),
                      const SizedBox(width: 20),
                      BTN(
                          widget: Text('Delete'.tr),
                          color: Colors.red,
                          width: 100,
                          press: () {
                            controller
                                .deleteProduct(controller.product.productID);
                          }),
                    ],
                  ),
                ),
                const imageSlider(),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TitleAndQuantity(product: controller.product),
                  const SizedBox(height: 10),
                  const productDesc(),
                  const SizedBox(height: 10),
                  const ColorsandSizes(),
                ])
              ])));
    });
  }
}
