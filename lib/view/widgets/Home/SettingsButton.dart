import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Login/login.dart';
import '../../../core/constants/AppColors.dart';

class SettingsButton extends GetView<LoginControllerImp> {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Builder(builder: (context) {
      return GetBuilder<HomeController>(builder: (context) {
        return PopupMenuButton(
          icon: Icon(Icons.settings,
              size: 20,
              color: homeController.isDarkMode
                  ? AppColors.white
                  : AppColors.black),
          position: PopupMenuPosition.under,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          itemBuilder: (context) => [
            PopupMenuItem(child: GetBuilder<HomeController>(builder: (context) {
              return ExpansionTile(
                title: Text("lang".tr),
                tilePadding: EdgeInsets.zero,
                children: [
                  RadioListTile(
                    value: 'ar',
                    groupValue: homeController.selectedLang,
                    title: const Text("Arabic"),
                    onChanged: (value) {
                      homeController.changeLang(value);
                      Get.back();
                    },
                  ),
                  RadioListTile(
                    value: 'en',
                    groupValue: homeController.selectedLang,
                    title: const Text("English"),
                    onChanged: (value) {
                      homeController.changeLang(value);
                      Get.back();
                    },
                  )
                ],
              );
            })),
            PopupMenuItem(child: GetBuilder<HomeController>(builder: (context) {
              return SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.all(0),
                value: homeController.isDarkMode,
                title: Text("darkmode".tr),
                onChanged: (value) => homeController.changeThemeMode(value),
              );
            })),
            PopupMenuItem(
                onTap: () => controller.logout(),
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded, color: Colors.red),
                    const SizedBox(width: 20),
                    Text('logout'.tr,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                )),
          ],
        );
      });
    });
  }
}
