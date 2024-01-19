import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/data/Model/MonthlyOrders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../controller/orders/ordersController.dart';
import '../../../data/Model/CategoriesSales.dart';
import '../../../data/Model/DailyOrders.dart';

class DashboardCharts extends StatelessWidget {
  const DashboardCharts({super.key});

  @override
  Widget build(BuildContext context) {
    ordersController orderController = Get.find();
    orderController.getOrdersPerDay();
    orderController.getOrdersperMonth();

    return const Row(
      children: [
        OrdersSalesChart(),
        SizedBox(width: 10),
        CategoriesSalesChart()
      ],
    );
  }
}

class OrdersSalesChart extends GetView<HomeController> {
  const OrdersSalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    TooltipBehavior dailyTooltipBehavior = TooltipBehavior(
        enable: true, duration: 1500, format: "Day point.x : point.y Order");
    TooltipBehavior monthlyTooltipBehavior = TooltipBehavior(
        enable: true, duration: 1500, format: "point.x : point.y Order");
    return Expanded(
      flex: 4,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: controller.isDarkMode
            ? const Color.fromARGB(231, 36, 34, 42)
            : const Color.fromARGB(255, 244, 241, 248),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<ordersController>(builder: (oc) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text("OrdersAnalytics".tr,
                        style: TextStyle(fontSize: 28, color: ThemeColorFix())),
                    const Spacer(),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: controller.isDarkMode
                          ? const Color.fromARGB(231, 36, 34, 42)
                          : const Color.fromARGB(255, 244, 241, 248),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                            value: oc.selectedChart,
                            underline: const SizedBox(),
                            dropdownColor: controller.isDarkMode
                                ? const Color.fromARGB(231, 36, 34, 42)
                                : const Color.fromARGB(255, 244, 241, 248),
                            iconEnabledColor: ThemeColorFix(),
                            items: [
                              DropdownMenuItem(
                                  value: 0,
                                  child: Text("Daily".tr,
                                      style:
                                          TextStyle(color: ThemeColorFix()))),
                              DropdownMenuItem(
                                  value: 1,
                                  child: Text("Monthly".tr,
                                      style:
                                          TextStyle(color: ThemeColorFix()))),
                            ],
                            onChanged: (value) => oc.changeChart(value),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                oc.selectedChart == 0
                    ? SfCartesianChart(
                        enableAxisAnimation: true,
                        tooltipBehavior: oc.selectedChart == 0
                            ? dailyTooltipBehavior
                            : monthlyTooltipBehavior,
                        primaryXAxis: CategoryAxis(
                            // majorGridLines: const MajorGridLines(width: 0),
                            labelStyle: TextStyle(
                                color: controller.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black)),
                        primaryYAxis: NumericAxis(
                            // majorGridLines: const MajorGridLines(width: 0),
                            labelStyle: TextStyle(
                                color: controller.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black)),
                        series: [
                          SplineSeries<DailyOrders, int>(
                            dataSource: <DailyOrders>[...oc.dailyOrders],
                            xValueMapper: (DailyOrders m, _) => m.day,
                            yValueMapper: (DailyOrders m, _) => m.numOfOrders,
                            width: 4,
                            isVisible: oc.selectedChart == 0 ? true : false,
                            enableTooltip: true,
                            name: 'NumberofOrders'.tr,
                          ),
                        ],
                      )
                    : SfCartesianChart(
                        enableAxisAnimation: true,
                        tooltipBehavior: oc.selectedChart == 0
                            ? dailyTooltipBehavior
                            : monthlyTooltipBehavior,
                        primaryXAxis: CategoryAxis(
                            labelStyle: TextStyle(
                                color: controller.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black)),
                        primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(
                                color: controller.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black)),
                        series: [
                          ColumnSeries<MonthlyOrders, dynamic>(
                            dataSource: <MonthlyOrders>[...oc.monthlyOrders],
                            xValueMapper: (MonthlyOrders m, _) => m.month,
                            yValueMapper: (MonthlyOrders m, _) => m.numOfOrders,
                            color: Colors.redAccent,
                            isVisible: oc.selectedChart == 1 ? true : false,
                            enableTooltip: true,
                            name: 'NumberofOrders'.tr,
                          ),
                        ],
                      )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class CategoriesSalesChart extends GetView<HomeController> {
  const CategoriesSalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    TooltipBehavior tooltipBehavior =
        TooltipBehavior(enable: true, format: 'point.x : point.y%');
    return GetBuilder<ordersController>(builder: (oc) {
      return Expanded(
        flex: 2,
        child: SizedBox(
          height: 415,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: controller.isDarkMode
                ? const Color.fromARGB(231, 36, 34, 42)
                : const Color.fromARGB(255, 244, 241, 248),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CategoriesSales".tr,
                      style: TextStyle(
                          fontSize: 28,
                          color: controller.isDarkMode
                              ? AppColors.white
                              : AppColors.black)),
                  const SizedBox(height: 20),
                  SfCircularChart(
                    tooltipBehavior: tooltipBehavior,
                    series: <PieSeries>[
                      PieSeries<CategoriesSales, dynamic>(
                          radius: '63%',
                          dataSource: <CategoriesSales>[...oc.categoriesSales],
                          xValueMapper: (CategoriesSales categoriesSale, _) =>
                              categoriesSale.name,
                          yValueMapper: (CategoriesSales categoriesSale, _) =>
                              categoriesSale.value,
                          pointColorMapper:
                              (CategoriesSales categoriesSale, _) =>
                                  categoriesSale.color,
                          dataLabelMapper:
                              (CategoriesSales categoriesSale, _) =>
                                  categoriesSale.name.toString(),
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            color: AppColors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                            labelIntersectAction: LabelIntersectAction.none,
                            overflowMode: OverflowMode.none,
                            showZeroValue: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            connectorLineSettings: ConnectorLineSettings(
                                type: ConnectorType.curve),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
