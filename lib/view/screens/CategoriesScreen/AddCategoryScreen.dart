import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dashboard/controller/Categories/CategoriesController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/core/shared/customField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Home/HomeController.dart';

class AddCategoryScreen extends GetView<CategoriesController> {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return GetBuilder<CategoriesController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("CreateNewCategory".tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: homeController.isDarkMode
                      ? AppColors.white
                      : AppColors.black)),
          const SizedBox(height: 50),
          Form(
            key: formkey,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 400,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      customField(
                          textEditingController: controller.name,
                          lable: "CategoryName".tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "notEmpty".tr;
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      customField(
                          textEditingController: controller.nameAr,
                          lable: "CategoryNameAr".tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "notEmpty".tr;
                            }
                            return null;
                          }),
                      const SizedBox(height: 25),
                      BTN(
                          widget: Text("PickImage".tr),
                          width: 150,
                          press: () => controller.pickCategoryImage()),
                      const SizedBox(height: 5),
                      const Text("Only Allow SVG",
                          style: TextStyle(color: AppColors.secondryColor)),
                      const SizedBox(height: 50),
                      BTN(
                          widget:
                              controller.statusRequest == StatusRequest.loading
                                  ? const SizedBox(
                                      height: 17,
                                      width: 17,
                                      child: CircularProgressIndicator(
                                          color: AppColors.white,
                                          strokeWidth: 4),
                                    )
                                  : Text("Create".tr),
                          width: 150,
                          color: AppColors.secondryColor,
                          press: () {
                            if (formkey.currentState!.validate()) {
                              controller.createCategories();
                            }
                          })
                    ])),
                const SizedBox(width: 40),
                if (controller.image != null)
                  // controller.image!.extension.endsWith('svg')
                  SvgPicture.memory(controller.image!.bytes!, width: 150)
                // : Image.memory(controller.image.bytes, width: 150)
              ],
            ),
          ),
        ],
      );
    });
  }
}
