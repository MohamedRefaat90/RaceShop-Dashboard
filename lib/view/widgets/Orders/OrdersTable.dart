import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/data/Model/OrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';

import '../../../controller/Home/HomeController.dart';
import '../../../controller/orderDetails/orderDetailsController.dart';
import '../../../controller/orders/ordersController.dart';

class OrdersTable extends GetView<ordersController> {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    orderDetailsController odc = Get.put(orderDetailsController());
    return DataTable(
      showCheckboxColumn: false,
      columnSpacing: 30,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          // color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      // dataRowColor: const MaterialStatePropertyAll(AppColors.white),
      dataTextStyle: TextStyle(color: ThemeColorFix()),
      headingTextStyle: TextStyle(color: ThemeColorFix()),
      border: TableBorder.all(
          color: ThemeColorFix(),
          width: 2,
          borderRadius: BorderRadius.circular(20)),
      dataRowMinHeight: 20,
      columns: [
        DataColumn(
            label: Text(
          'index'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text('User'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataColumn(
            label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text('Zone'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataColumn(
            label: Text('ShippingFee'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('TotalPrice'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('PaymentMethod'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('numofItems'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Date'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Status'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        )),
      ],
      rows: List.generate(
          controller.orders.length,
          (index) => DataRow(
                  selected: false,
                  onSelectChanged: (value) {
                    homeController.changePage(7);
                    odc.order = OrderModel.fromJson(controller.orders[index]);
                    odc.selectedOrder = index;
                  },
                  cells: [
                    DataCell(Center(child: Text((index + 1).toString()))),
                    DataCell(Center(
                      child:
                          SelectableText("${controller.orders[index]['user']}"),
                    )),
                    DataCell(Center(
                        child: Text("${controller.orders[index]['zoneEn']}"))),
                    DataCell(Center(
                      child:
                          Text("${controller.orders[index]['delevieryPrice']}"),
                    )),
                    DataCell(Center(
                        child:
                            Text("${controller.orders[index]['totalPrice']}"))),
                    DataCell(Center(
                      child:
                          Text("${controller.orders[index]['paymentMethod']}"),
                    )),
                    DataCell(Center(
                        child: Text(
                            "${controller.orders[index]['items'].length}"))),
                    DataCell(Center(
                        child: Text(DateFormat.yMd().format(DateTime.parse(
                            controller.orders[index]['createdAt']))))),
                    DataCell(Text("${controller.orders[index]['status']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.orders[index]['status'] ==
                                    'completed'
                                ? Colors.green
                                : controller.orders[index]['status'] ==
                                        'pending'
                                    ? Colors.purple
                                    : controller.orders[index]['status'] ==
                                            'outForDeleviery'
                                        ? Colors.amber
                                        : Colors.red))),
                  ])),
    );
  }
}
