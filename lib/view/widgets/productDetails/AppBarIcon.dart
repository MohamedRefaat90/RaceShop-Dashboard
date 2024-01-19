import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Product/ProductController.dart';
import '../../../core/constants/AppColors.dart';

class AppBarIcon extends GetView<ProductDetailsControllerImp> {
  const AppBarIcon({
    required this.color,
    required this.x,
    required this.icon,
    required this.press,
    required this.alignment,
    super.key,
  });
  final IconData icon;
  final void Function()? press;
  final Alignment alignment;
  final double x;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    offset: Offset(x, 18),
                    color: AppColors.black,
                    spreadRadius: -14,
                    blurRadius: 35)
              ]),
          child: IconButton(onPressed: press, icon: Icon(icon, color: color))),
    );
  }
}
