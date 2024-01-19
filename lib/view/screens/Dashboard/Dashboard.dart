import 'package:dashboard/controller/Categories/CategoriesController.dart';
import 'package:dashboard/core/shared/HandleingRequsetData.dart';
import 'package:dashboard/view/widgets/Dashboard/StaticsCards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Dashboard/DashboardCharts.dart';

class Dashboard extends GetView<CategoriesController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesController());

    return GetBuilder<CategoriesController>(builder: (context) {
      return HandleingRequsetData(
        statusRequest: controller.statusRequest!,
        widget: const SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaticsCards(),
                SizedBox(height: 20),
                DashboardCharts()
              ]),
        ),
      );
    });
  }
}
