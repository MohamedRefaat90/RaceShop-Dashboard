import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/functions/handelDataController.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/shared/BTN.dart';
import '../../data/Model/DeliveryZoneModel.dart';
import '../../data/dataSource/remote/DeleiveryZoneData/DeleiveryZoneData.dart';

class ZoneController extends GetxController {
  StatusRequest? statusRequest;
  DelevieryZoneData zoneData = DelevieryZoneData(Get.find());
  List zones = [];
  late String userToken;
  int? editZoneindex;
  MyServices myServices = Get.find();
  HomeController homeController = Get.find();
  TextEditingController zoneName = TextEditingController();
  TextEditingController zoneNameAr = TextEditingController();
  TextEditingController zoneFee = TextEditingController();
  TextEditingController zoneTime = TextEditingController();
  late TextEditingController editzoneName;
  late TextEditingController editzoneNameAr;
  late TextEditingController editzoneFee;
  late TextEditingController editzoneTime;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> editFormkey = GlobalKey<FormState>();
  @override
  void onInit() {
    userToken = myServices.sharedPreferences.getString('userToken')!;
    getAllZones();
    super.onInit();
  }

  createZone() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await zoneData.createZone(data: {
      "zoneName_en": zoneName.text,
      "zoneName_ar": zoneNameAr.text,
      "delevieryFee": zoneFee.text,
      "delevieryTimeInDays": zoneTime.text
    }, userToken: userToken);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      zoneName.text = '';
      zoneNameAr.text = '';
      zoneFee.text = '';
      zoneTime.text = '';
      homeController.changePage(3);
      getAllZones();
    }
  }

  getAllZones() async {
    zones.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await zoneData.getZone();

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        zones.addAll(
            response['data']['data'].map((e) => DeliveryZoneModel.fromJson(e)));
      }
    }

    update();
  }

  updateZone(String zoneID) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await zoneData.updateZone(
        zoneID: zoneID,
        data: {
          "zoneName_en": editzoneName.text,
          "zoneName_ar": editzoneNameAr.text,
          "delevieryFee": editzoneFee.text,
          "delevieryTimeInDays": editzoneTime.text
        },
        userToken: userToken);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      zoneName.text = '';
      zoneNameAr.text = '';
      zoneFee.text = '';
      zoneTime.text = '';
      homeController.changePage(3);
      getAllZones();
    }
  }

  deleteZone({required String zoneID}) {
    Get.defaultDialog(
        title: "Warrning".tr,
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_rounded, color: Colors.amber, size: 40),
            Text("DeleteZone".tr),
          ],
        ),
        confirm: BTN(
            widget: Text("Confirm".tr),
            padding: 20,
            color: Colors.green,
            press: () {
              zoneData.deleteZone(zoneID: zoneID, userToken: userToken);
              zones.removeWhere((e) => e.id == zoneID);
              Get.back();
              update();
            }),
        cancel: BTN(
            widget: Text("Cancel".tr),
            color: Colors.red,
            press: () => Get.back()));
  }
}
