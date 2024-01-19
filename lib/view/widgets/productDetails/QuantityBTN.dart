import 'package:flutter/material.dart';

class QuantityBTN extends StatelessWidget {
  const QuantityBTN({
    required this.icon,
    required this.press,
    super.key,
  });
  final IconData icon;
  final void Function()? press;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: press, icon: Icon(icon, size: 25));
  }
}
