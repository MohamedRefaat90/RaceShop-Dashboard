import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('welcome'.tr,
        style:
            Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 35));
  }
}
