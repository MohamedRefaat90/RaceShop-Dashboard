import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/orderDetails/orderDetailsController.dart';
import 'orderDetailsitemCard.dart';

class OrderDetailsItems extends GetView<orderDetailsController> {
  const OrderDetailsItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1, mainAxisSpacing: 20),
      itemCount: controller.order.items!.length,
      itemBuilder: (context, index) => orderDetailsItemCard(
          productName: controller.order.items![index].productName!,
          productImage: controller.order.items![index].coverImage!,
          productColor:
              controller.order.items![index].selectedVariation!.color!,
          productPrice: controller.order.items![index].price ?? 2000,
          productSize: controller.order.items![index].selectedVariation!.size!,
          discount: controller.order.items![index].discount ?? 50,
          quantity: controller.order.items![index].quantity ?? 2,
          index: index),
    );
  }
}
