import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/Dashboard/DashboardController.dart';
import '../../../controller/orders/ordersController.dart';
import '../../../core/class/statusRequest.dart';
import '../../../core/constants/AppColors.dart';

class StaticsCards extends GetView<DashboardController> {
  const StaticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    ordersController orderController = Get.put(ordersController());
    Get.put(DashboardController());
    orderController.getAllOrders();

    return SizedBox(
      height: 150,
      child: GetBuilder<ordersController>(builder: (context) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.staticsCards.length,
            itemBuilder: (context, index) => orderController.statusRequest ==
                    StatusRequest.loading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade500,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 300,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: controller.staticsCards[index]
                                  ['gridientColors']),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                : Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: controller.staticsCards[index]
                                ['gridientColors']),
                        borderRadius: BorderRadius.circular(20)),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontSize: 18),
                      child: Stack(children: [
                        Positioned(
                          bottom: 0,
                          child: Transform.rotate(
                            angle: (pi *
                                    controller.staticsCards[index]
                                        ['rotateAngle']) /
                                180,
                            child: SvgPicture.asset(
                                controller.staticsCards[index]['svgPic'],
                                color: AppColors.white.withOpacity(0.3),
                                width: 120),
                          ),
                        ),
                        Positioned(
                            top: 20,
                            left: 30,
                            child:
                                Text(controller.staticsCards[index]['title'])),
                        Positioned(
                            top: 60,
                            right: 30,
                            child: Text(
                                "${index == 0 ? orderController.compeletedOrders.length < 10 ? "0${orderController.compeletedOrders.length}" : orderController.compeletedOrders.length : index == 1 ? orderController.pendingOrders.length < 10 ? "0${orderController.pendingOrders.length}" : orderController.pendingOrders.length : orderController.orders.length < 10 ? "0${orderController.orders.length}" : orderController.orders.length}",
                                style: const TextStyle(fontSize: 50)))
                      ]),
                    )));
      }),
    );
  }
}
