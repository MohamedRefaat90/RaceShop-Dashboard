import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/orderDetails/orderDetailsController.dart';
import 'package:dashboard/controller/orders/ordersController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/orderDetails/orderDetailsAddress.dart';
import '../../widgets/orderDetails/orderDetailsItems.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ordersController oc = Get.find();
    Get.put(orderDetailsController());
    return GetBuilder<orderDetailsController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                      children: [
                        TextSpan(text: "OrdersDetails#".tr),
                        TextSpan(text: "#${controller.selectedOrder! + 1}")
                      ],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: ThemeColorFix()))),
                  const SizedBox(height: 10),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: OrderDetailsItems()),
                      Expanded(child: OrderDetailsAddress()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          GetBuilder<orderDetailsController>(builder: (controller) {
            return Container(
              width: 400,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: ThemeColorFix())),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "OrderStatus:".tr,
                        style: TextStyle(color: ThemeColorFix())),
                    TextSpan(
                        text: "${controller.order.status}".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: controller.order.status == "completed"
                                ? Colors.green
                                : controller.order.status == "pending"
                                    ? Colors.purple
                                    : controller.order.status ==
                                            "outForDeleviery"
                                        ? Colors.amber
                                        : Colors.red)),
                  ])),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (controller.order.status == "pending")
                      BTN(
                          widget:
                              controller.statusRequest == StatusRequest.loading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          color: AppColors.white))
                                  : Text('Prepared'.tr),
                          width: 110,
                          color: Colors.purple,
                          press: () => controller.changeOrderStatus(
                              controller.order.sId!, 'outForDeleviery')),
                    const SizedBox(width: 20),
                    if (controller.order.status == "outForDeleviery")
                      BTN(
                          widget:
                              controller.statusRequest == StatusRequest.loading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          color: AppColors.white))
                                  : const Text('Completed'),
                          width: 110,
                          color: Colors.green,
                          press: () {
                            controller.changeOrderStatus(
                                controller.order.sId!, 'completed');
                            oc.getAllOrders();
                          }),
                    const SizedBox(width: 20),
                    if (controller.order.status != "completed" &&
                        controller.order.status != "canceled")
                      BTN(
                          widget:
                              controller.statusRequest == StatusRequest.loading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          color: AppColors.white))
                                  : const Text('Cancel'),
                          width: 110,
                          color: Colors.red,
                          press: () {
                            controller.cancelOrder(controller.order.sId!);
                          })
                  ]),
                ],
              ),
            );
          }),
        ],
      );
    });
  }
}
