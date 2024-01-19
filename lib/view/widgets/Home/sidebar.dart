// ignore: unused_import
import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/core/localization/changeLanguage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../controller/Home/HomeController.dart';
import '../../../core/constants/AppAssets.dart';
import '../../../core/constants/AppColors.dart';

class sidebar extends GetView<HomeController> {
  const sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Expanded(
        flex: 1,
        child: GetBuilder<HomeController>(builder: (controller) {
          return Container(
              decoration: BoxDecoration(
                  color:
                      controller.isDarkMode ? AppColors.black : AppColors.white,
                  borderRadius: homeController.selectedLang! == "en"
                      ? const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
              padding: const EdgeInsets.only(bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(child: Image.asset(AppAssets.logo)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                            controller.menu.length,
                            (index) => GetBuilder<HomeController>(
                                    builder: (controller) {
                                  return Card(
                                    elevation: controller.selectedPage == index
                                        ? 5
                                        : 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color:
                                        controller.getColorSidebarTial(index),
                                    shadowColor:
                                        const Color.fromARGB(70, 174, 137, 255),
                                    child: ListTile(
                                      onTap: () => controller.changePage(index),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      leading: SvgPicture.asset(
                                          controller.menu[index]['icon'],
                                          color: controller
                                              .getColorSidebarTialIcon(index)),
                                      title: Text(
                                          "${controller.menu[index]['title']}"
                                              .tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: controller
                                                  .getColorSidebarTialText(
                                                      index))),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ],
                ),
              ));
        }));
  }
}
