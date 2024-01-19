import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/core/functions/translate.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:dashboard/core/shared/HandleingRequsetData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/Zone/zoneController.dart';

class DeliveryZoneScreen extends GetView<ZoneController> {
  const DeliveryZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ZoneController());
    HomeController homeController = Get.find();
    return GetBuilder<ZoneController>(builder: (controller) {
      return HandleingRequsetData(
        statusRequest: controller.statusRequest!,
        widget: ListView(shrinkWrap: true, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("DeliveryZones".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: ThemeColorFix())),
              BTN(
                  widget: Text('AddZone'.tr),
                  width: 150,
                  padding: 17,
                  press: () => homeController.changePage(8))
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0),
            child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 30,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                dataTextStyle: TextStyle(fontSize: 18, color: ThemeColorFix()),
                headingTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeColorFix()),
                border: TableBorder.all(
                    color: ThemeColorFix(),
                    width: 2,
                    borderRadius: BorderRadius.circular(20)),
                dataRowMinHeight: 20,
                columns: [
                  DataColumn(
                      label: Expanded(child: Center(child: Text('Zone'.tr)))),
                  DataColumn(
                      label: Expanded(child: Center(child: Text('Fee'.tr)))),
                  DataColumn(
                      label: Expanded(
                          child: Center(child: Text('TimeinDays'.tr)))),
                  DataColumn(
                      label:
                          Expanded(child: Center(child: Text('CreatedAt'.tr)))),
                  DataColumn(
                      label:
                          Expanded(child: Center(child: Text('UpdatedAt'.tr)))),
                  DataColumn(
                      label: Expanded(child: Center(child: Text('Actions'.tr))))
                ],
                rows: List.generate(
                    controller.zones.length,
                    (index) => DataRow(cells: [
                          DataCell(Center(
                              child: Text(translate(
                                  controller.zones[index].zoneNameEn,
                                  controller.zones[index].zoneNameAr)))),
                          DataCell(Center(
                              child: Text(controller.zones[index].delevieryFee
                                  .toString()))),
                          DataCell(
                            Center(
                                child: Text(controller
                                    .zones[index].delevieryTimeInDays
                                    .toString())),
                          ),
                          DataCell(
                            Center(
                              child: Text(DateFormat.yMd().add_jms().format(
                                  DateTime.parse(
                                      controller.zones[index].createdAt))),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(DateFormat.yMd().add_jms().format(
                                  DateTime.parse(
                                      controller.zones[index].updatedAt))),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.purple, size: 25),
                                    onPressed: () {
                                      controller.editZoneindex = index;
                                      homeController.changePage(9);
                                      controller.editzoneName =
                                          TextEditingController(
                                              text: controller
                                                  .zones[index].zoneNameEn);
                                      controller.editzoneNameAr =
                                          TextEditingController(
                                              text: controller
                                                  .zones[index].zoneNameAr);
                                      controller.editzoneFee =
                                          TextEditingController(
                                              text: controller
                                                  .zones[index].delevieryFee
                                                  .toString());
                                      controller.editzoneTime =
                                          TextEditingController(
                                              text: controller.zones[index]
                                                  .delevieryTimeInDays
                                                  .toString());
                                    }),
                                IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red, size: 25),
                                    onPressed: () => controller.deleteZone(
                                        zoneID: controller.zones[index].id)),
                              ],
                            ),
                          ),
                        ]))),
          )
        ]),
      );
    });
  }
}
