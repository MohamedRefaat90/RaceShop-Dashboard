import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/controller/orders/ordersController.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/functions/handelDataController.dart';
import 'package:dashboard/data/Model/OrderModel.dart';
import 'package:dashboard/data/dataSource/remote/Orders/OrdersData.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

import '../../core/services/myServices.dart';

class orderDetailsController extends GetxController {
  late OrderModel order;
  StatusRequest? statusRequest;
  OrdersData ordersData = OrdersData(Get.find());
  ordersController oc = Get.find();
  HomeController homeController = Get.find();
  int? selectedOrder;
  MyServices myServices = Get.find();
  late String userToken;
/*
  mohamedrefaat900@gmail.com 
  test1234T@
 */
  @override
  void onInit() {
    userToken = myServices.sharedPreferences.getString('userToken')!;
    super.onInit();
  }

  changeOrderStatus(String orderID, String status) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await ordersData.changeOrderStatus(orderID, status, userToken);
    statusRequest = handelData(response);
    homeController.selectedPage = 2;
    homeController.update();
    oc.getAllOrders();
    oc.update();
  }

  cancelOrder(String orderID) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.cancelOrder(orderID, userToken);
    statusRequest = handelData(response);
    homeController.selectedPage = 2;
    homeController.update();
    oc.getAllOrders();
    oc.update();
  }
}
