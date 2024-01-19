import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/AppAssets.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    return Center(
        child: Lottie.asset(
            controller.isDarkMode
                ? AppAssets.lightLoading
                : AppAssets.darkLoading,
            width: MediaQuery.of(context).size.width * 0.30));
  }
}
