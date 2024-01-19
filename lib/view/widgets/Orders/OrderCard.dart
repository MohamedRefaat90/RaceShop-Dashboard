import 'package:dashboard/core/class/statusRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../controller/orders/ordersController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/constants/AppRoutes.dart';
import '../../../core/shared/BTN.dart';
import '../../../core/shared/Loading.dart';
import '../../../data/Model/OrderModel.dart';
import 'orderStatusStepper.dart';

class orderCard extends GetView<ordersController> {
  const orderCard({super.key, required this.order, required this.index});
  final OrderModel order;
  final int index;
  @override
  Widget build(BuildContext context) {
    controller.changeStepper(order.status!);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: GetBuilder<ordersController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Number : ${index + 1}",
                      style: const TextStyle(fontSize: 20)),
                  Text(Jiffy.parse(order.createdAt!).fromNow()),
                ],
              ),
              const SizedBox(height: 10),
              Text('Payment Type : ${order.paymentMethod}'),
              const SizedBox(height: 5),
              Text('Order Price : ${order.totalItemsPrice} LE'),
              const SizedBox(height: 5),
              Text('Shipping Price : ${order.delevieryPrice} LE'),
              const SizedBox(height: 5),
              if (order.coupon != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coupon : ${order.coupon['name']}'),
                    const SizedBox(height: 5),
                    if (order.coupon != null)
                      Text('Coupon Discount : ${order.coupon['discount']} %'),
                    const SizedBox(height: 5),
                  ],
                ),
              Text('Shipping Time : With in ${order.delevieryTimeInDays} Days'),
              const SizedBox(height: 5),
              Text(
                  "Order Status : ${order.status == "canceled" || order.status == "canceledBeforePending" ? "Canceled" : ""}"),
              if (order.status != "canceled" &&
                  order.status != "canceledBeforePending")
                const orderStatusStepper(),
              const SizedBox(height: 5),
              const Divider(
                  thickness: 3,
                  indent: 50,
                  endIndent: 50,
                  color: AppColors.primaryColor),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Total Price : ${order.totalPrice} LE',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  const Spacer(),
                  if (order.status == "pending")
                    BTN(
                        widget: const Text("Cancel"),
                        color: AppColors.secondryColor,
                        press: () {
                          if (order.sId == controller.orders[index]['_id']) {
                            controller.cancelOrder(order.sId!);
                          }
                        },
                        padding: 12),
                  if (order.status != "pending" &&
                      order.status != "preCheckout")
                    BTN(
                        widget: const Text("Order Details"),
                        press: () {
                          Get.toNamed(AppRoutes.ordersDetails,
                              arguments: {"order": order});
                        },
                        padding: 12)
                ],
              ),
              const SizedBox(height: 10),
              if (order.status == "pending" || order.status == "preCheckout")
                BTN(
                    widget: const Text("Order Details"),
                    width: double.infinity,
                    press: () {
                      Get.toNamed(AppRoutes.ordersDetails,
                          arguments: {"order": order});
                    },
                    padding: 12)
            ],
          ),
        );
      }),
    );
  }
}
