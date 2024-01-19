import 'package:dashboard/core/shared/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ordersHistory/ordersHistoryController.dart';
import '../../../core/class/statusRequest.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/shared/HandleingRequsetData.dart';
import '../../../core/shared/Loading.dart';
import '../../../data/Model/OrderModel.dart';

import '../../widgets/ordersHistory/orderCompeletedCard.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ordersHistoryController());
    return Scaffold(
      appBar: customAppBar(context, "Orders History"),
      backgroundColor: AppColors.white.withOpacity(0.9),
      body: GetBuilder<ordersHistoryController>(builder: (controller) {
        return HandleingRequsetData(
            statusRequest: controller.statusRequest!,
            widget: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.compeletedOrders.length,
                itemBuilder: (context, index) =>
                    controller.statusRequest == StatusRequest.none
                        ? Loading()
                        : orderCompeletedCard(
                            order: OrderModel.fromJson(
                                controller.compeletedOrders[index]),
                            index: index)));
      }),
    );
  }
}
