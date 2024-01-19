import 'package:dashboard/core/constants/AppColors.dart';
import 'package:flutter/material.dart';

class BTN extends StatelessWidget {
  const BTN(
      {super.key,
      required this.widget,
      required this.press,
      this.color,
      this.padding,
      this.width,
      this.isDisabled = false});
  final Widget widget;
  final void Function()? press;
  final Color? color;
  final double? padding;
  final double? width;
  final bool isDisabled;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      animationDuration: const Duration(milliseconds: 300),
      onPressed: isDisabled ? null : press,
      padding: EdgeInsets.all(padding ?? 20),
      minWidth: width ?? 50,
      textColor: Colors.white,
      color: color ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      enableFeedback: true,
      disabledColor: Colors.grey,
      child: widget,
    );
  }
}
