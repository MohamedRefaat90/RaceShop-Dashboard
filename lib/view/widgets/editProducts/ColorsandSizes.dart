import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Home/HomeController.dart';
import '../../../controller/product/ProductController.dart';
import '../../../core/constants/AppColors.dart';

class ColorsandSizes extends GetView<ProductDetailsControllerImp> {
  const ColorsandSizes({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return GetBuilder<ProductDetailsControllerImp>(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ColorsandSizes'.tr,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: homeController.isDarkMode
                      ? AppColors.white
                      : AppColors.black)),
          SizedBox(height: 10),
          DataTable(
              border: TableBorder.all(
                  color: homeController.isDarkMode
                      ? AppColors.white
                      : AppColors.black,
                  borderRadius: BorderRadius.circular(20)),
              columns: [
                DataColumn(
                  label: Text("Size".tr,
                      style: TextStyle(
                          color: homeController.isDarkMode
                              ? AppColors.white
                              : AppColors.black)),
                ),
                DataColumn(
                  label: Text("Quantity/Color".tr,
                      style: TextStyle(
                          color: homeController.isDarkMode
                              ? AppColors.white
                              : AppColors.black)),
                ),
              ],
              rows: List.generate(
                  controller.editProductVariationsSize.length,
                  (index) => DataRow(cells: [
                        DataCell(Center(
                            child: Text(
                                controller.editProductVariationsSize[index].keys
                                    .elementAt(0),
                                style: TextStyle(
                                    color: homeController.isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.bold)))),
                        DataCell(SizedBox(
                          width: 150,
                          height: 40,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .editProductVariationsSize[index].values
                                  .elementAt(0)
                                  .length,
                              itemBuilder: (context, i) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 7,
                                        backgroundColor:
                                            controller.productColors[controller
                                                .editProductVariationsSize[
                                                    index]
                                                .values
                                                .elementAt(0)[i]['color']],
                                      ),
                                      Text(
                                          controller
                                              .editProductVariationsSize[index]
                                              .values
                                              .elementAt(0)[i]['quantity']
                                              .toString(),
                                          style: TextStyle(
                                              color: homeController.isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20)),
                        )),
                      ])))
        ],
      );
    });
  }
}
