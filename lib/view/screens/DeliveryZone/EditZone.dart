import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/Zone/zoneController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusRequest.dart';
import '../../../core/shared/BTN.dart';
import '../../../core/shared/customField.dart';

class EditZoneScreen extends GetView<ZoneController> {
  const EditZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Form(
      key: controller.editFormkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
              TextSpan(children: [
                TextSpan(text: "Edit".tr),
                TextSpan(text: "Zone".tr),
                TextSpan(
                    text: translate(
                        controller.zones[controller.editZoneindex!].zoneNameEn,
                        controller.zones[controller.editZoneindex!].zoneNameAr),
                    style: const TextStyle(color: AppColors.primaryColor)),
              ]),
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: homeController.isDarkMode
                      ? AppColors.white
                      : AppColors.black)),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 300,
                      child: customField(
                          lable: "ZoneName".tr,
                          textEditingController: controller.editzoneName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't be Empty";
                            }
                            return null;
                          })),
                  const SizedBox(width: 20),
                  SizedBox(
                      width: 300,
                      child: customField(
                          lable: "ZoneNameAr".tr,
                          textEditingController: controller.editzoneNameAr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't be Empty";
                            }
                            return null;
                          })),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 300,
                      child: customField(
                        lable: "ZoneFee".tr,
                        textEditingController: controller.editzoneFee,
                        validator: (value) {
                          if (!GetUtils.isNumericOnly(value!)) {
                            return "Enter Only Numbers";
                          }
                          return null;
                        },
                      )),
                  const SizedBox(width: 20),
                  SizedBox(
                      width: 300,
                      child: customField(
                          lable: "ZoneDeliveryDays".tr,
                          textEditingController: controller.editzoneTime,
                          validator: (value) {
                            if (!GetUtils.isNumericOnly(value!)) {
                              return "Enter Only Numbers";
                            }
                            return null;
                          })),
                ],
              ),
              const SizedBox(height: 30),
              GetBuilder<ZoneController>(builder: (context) {
                return BTN(
                    widget: controller.statusRequest == StatusRequest.loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: AppColors.white))
                        : Text("Edit".tr),
                    width: 200,
                    press: () {
                      if (controller.editFormkey.currentState!.validate()) {
                        controller.updateZone(
                            controller.zones[controller.editZoneindex!].id);
                      }
                    });
              })
            ],
          ),
        ],
      ),
    );
  }
}
