import 'package:flutter/material.dart';

import '../../../core/constants/AppColors.dart';

class QuantityNumber extends StatelessWidget {
  const QuantityNumber({
    required this.count,
    super.key,
  });
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
