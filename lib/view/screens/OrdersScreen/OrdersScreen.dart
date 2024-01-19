import 'package:dashboard/controller/orders/ordersController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/core/shared/HandleingRequsetData.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/Home/HomeController.dart';
import '../../../core/functions/ThemeColorFix.dart';
import '../../widgets/Orders/OrdersTable.dart';

class OrdersScreen extends GetView<ordersController> {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ordersController());
    controller.getAllOrders();
    return GetBuilder<ordersController>(builder: (controller) {
      return HandleingRequsetData(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ListView(
              // controller: controller.scrollController,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("orders".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: ThemeColorFix())),
                    BTN(
                        widget: Row(
                          children: [
                            const Icon(Icons.refresh),
                            const SizedBox(width: 10),
                            Text("Refresh".tr),
                          ],
                        ),
                        width: 100,
                        press: () => controller.getAllOrders())
                  ],
                ),
                const SizedBox(height: 30),
                const OrdersTable(),
                if (controller.loading == true)
                  const SizedBox(
                      height: 60,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor)))
              ],
            ),
          ));
    });
  }
}
