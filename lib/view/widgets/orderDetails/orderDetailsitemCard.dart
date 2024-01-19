import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/orderDetails/orderDetailsController.dart';
import '../../../core/constants/AppColors.dart';

class orderDetailsItemCard extends StatelessWidget {
  const orderDetailsItemCard(
      {super.key,
      required this.productName,
      required this.productColor,
      required this.productSize,
      required this.productPrice,
      required this.discount,
      required this.quantity,
      required this.productImage,
      required this.index});

  final String productName;
  final String productColor;
  final String productSize;
  final int productPrice;
  final String productImage;
  final int discount;
  final int quantity;
  final int index;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return GetBuilder<orderDetailsController>(builder: (controller) {
      return Stack(
        children: [
          Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: homeController.isDarkMode
                  ? const Color.fromARGB(231, 36, 34, 42)
                  : const Color.fromRGBO(240, 238, 243, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    orderDetails_Image(img: productImage),
                    orderDetails_Info(
                        name: productName,
                        price: productPrice,
                        color: productColor,
                        size: productSize,
                        discount: discount,
                        quantity: quantity),
                  ],
                ),
              )),
          if (controller.order.items![index].discount! > 0)
            Positioned(
                right: 20,
                top: 5,
                child: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 23,
                    child: Text("${controller.order.items![index].discount} %",
                        style: const TextStyle(color: AppColors.white))))
        ],
      );
    });
  }
}

class orderDetails_Info extends StatelessWidget {
  const orderDetails_Info(
      {super.key,
      required this.name,
      required this.price,
      required this.color,
      required this.size,
      required this.discount,
      required this.quantity});
  final String name;
  final int price;

  final String color;
  final String size;
  final int discount;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Expanded(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(fontSize: 18, color: ThemeColorFix())),
            const SizedBox(height: 10),
            Text('$price LE',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeColorFix())),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Color : $color", style: TextStyle(color: ThemeColorFix())),
              Text("Size : $size", style: TextStyle(color: ThemeColorFix())),
              Text("Quantity : $quantity",
                  style: TextStyle(color: ThemeColorFix()))
            ])
          ]),
    );
  }
}

class orderDetails_Image extends StatelessWidget {
  const orderDetails_Image({super.key, required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return Image.network(img, width: 130, height: 130);
  }
}
