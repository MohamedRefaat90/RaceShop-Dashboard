import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar(BuildContext context, String lable) {
  return AppBar(
    title: Text(
      lable.tr,
      style: Theme.of(context).textTheme.displayLarge,
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
