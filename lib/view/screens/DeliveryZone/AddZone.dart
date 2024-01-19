import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/Zone/zoneController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/core/shared/customField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddZoneScreen extends GetView<ZoneController> {
  const AddZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Form(
      key: controller.formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AddNewZone'.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: ThemeColorFix())),
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
                          textEditingController: controller.zoneName,
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
                          textEditingController: controller.zoneNameAr,
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
                        textEditingController: controller.zoneFee,
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
                          textEditingController: controller.zoneTime,
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
                        : Text("Create".tr),
                    width: 200,
                    press: () {
                      if (controller.formkey.currentState!.validate()) {
                        controller.createZone();
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
