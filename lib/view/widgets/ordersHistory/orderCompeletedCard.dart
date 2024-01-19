import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../controller/ordersHistory/ordersHistoryController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/constants/AppRoutes.dart';
import '../../../core/shared/BTN.dart';
import '../../../data/Model/OrderModel.dart';

class orderCompeletedCard extends StatelessWidget {
  const orderCompeletedCard(
      {super.key, required this.order, required this.index});
  final OrderModel order;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: GetBuilder<ordersHistoryController>(builder: (controller) {
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
              Text("Order Status : ${order.status}"),
              const SizedBox(height: 10),
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
                  BTN(
                      widget: const Text("Order Details"),
                      press: () {
                        Get.toNamed(AppRoutes.ordersDetails,
                            arguments: {"order": order});
                      },
                      padding: 12)
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
