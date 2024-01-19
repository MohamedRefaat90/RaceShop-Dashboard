import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/functions/handelDataController.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/data/Model/DailyOrders.dart';
import 'package:dashboard/data/Model/MonthlyOrders.dart';

import 'package:dashboard/data/dataSource/remote/Orders/OrdersData.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../data/Model/CategoriesSales.dart';
import '../Categories/CategoriesController.dart';
import '../Login/login.dart';

class ordersController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  OrdersData ordersData = OrdersData(Get.find());
  MyServices myServices = Get.find();
  String? userToken;
  List orders = [];
  List compeletedOrders = [];
  List pendingOrders = [];
  List ordersPerMonth = [];
  List ordersPerDay = [];
  List numOfOrdersPerDay = [];
  List ordersPerAllMonth = [];
  List numOfOrdersPermonth = [];
  List numOfOrdersPerYear = [];
  int activeStep = 0;
  late IO.Socket socket;
  late ScrollController scrollController;
  bool loading = false;
  int pageNumber = 1;
  int? totalPages;
  late List distinctOrdresDatePerDay;
  late List distinctOrdresDatePerMonth;

  List dailyOrders = [];
  List monthlyOrders = [];
  int? selectedChart = 0;

  List categoriesSales = [];

  CategoriesController categoriesController = Get.put(CategoriesController());
  @override
  void onInit() {
    userToken = myServices.sharedPreferences.getString("userToken");
    scrollController = ScrollController();
    // initSocket();
    // Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting('en');
    // getAllOrders();
    // getOrdersPerDay();
    // getOrdersperMonth();
    scrollController.addListener(pagination);
    super.onInit();
  }

  pagination() {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (pageNumber <= totalPages!)) {
      loading = true;
      pageNumber++;

      getAllOrders();

      update();
    }
  }

  initSocket() {
    socket = IO.io(
        "https://dashboard-api-lrnu.onrender.com",
        IO.OptionBuilder().setTransports(['websocket']).setAuth(
            {'auth': userToken!}).setQuery({'auth': userToken!}).build());
    socket.on('connect', (data) => print("Connected to server"));
    socket.onConnect((_) => print('Connection established'));
    socket.onReconnecting((_) => print('Reconnecting'));
    socket.onReconnectAttempt((_) => print('onReconnectAttempt'));
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err + " onConnectError"));
    socket.onError((err) => print(err + " onError"));
  }

  getAllOrders() async {
    orders.clear();
    compeletedOrders.clear();
    pendingOrders.clear();
    categoriesSales.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getAllOrders(userToken: userToken!);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        totalPages = response['data']['totalPages'];

        orders.addAll(response['data']['data']);
        categoriesSales = CategoriesSales.getCategoriesSales(
            categories: categoriesController.categories,
            numofOrders: orders.length);
        compeletedOrders = response['data']['data']
            .where((e) => e['status'] == "completed")
            .toList();

        pendingOrders = response['data']['data']
            .where((e) => e['status'] == "pending")
            .toList();
      }
    } else {
      statusRequest = StatusRequest.success;
      loading = false;
    }

    update();
  }

  cancelOrder(String orderID) async {
    await ordersData.cancelOrder(orderID, userToken!);
    getAllOrders();
  }

  changeStepper(String orderStatus) {
    switch (orderStatus) {
      case "pending":
        activeStep = 0;
        break;
      case "outForDeleviery":
        activeStep = 1;
        break;
      case "completed":
        activeStep = 3;
        break;
      default:
        activeStep = 0;
    }
  }

  getOrdersperMonth() async {
    statusRequest = StatusRequest.loading;
    // update();
    var response = await ordersData.getOrdersPerMonth(userToken: userToken!);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        ordersPerMonth.addAll(response['data']['data']);
        calcOrdersPerMonth();
        monthlyOrders = MonthlyOrders().getMonthlyOrders(
            ordersDates: distinctOrdresDatePerMonth,
            numOforders: numOfOrdersPerYear);
        update();
      }
    }
    update();
  }

  getOrdersPerDay() async {
    DailyOrders.calcDaysinMonth();
    statusRequest = StatusRequest.loading;
    // update();
    var response = await ordersData.getOrdersPerDay(userToken: userToken!);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        ordersPerDay.addAll(response['data']['data']);

        calcOrdersPerDay();
        dailyOrders = DailyOrders().getDailyOrders(
            numOforders: ordersPerAllMonth,
            ordersDates: distinctOrdresDatePerDay);
        update();
      }
    }

    update();
  }

  calcOrdersPerMonth() {
    List ordersDate = [];

    for (int i = 0; i < ordersPerMonth.length; i++) {
      // Get All Orders Date
      ordersDate.add(DateFormat.MMM()
          .format(DateTime.parse(ordersPerMonth[i]['createdAt'])));

      // Remove Duplicate Dates
      distinctOrdresDatePerMonth = ordersDate.toSet().toList();
    }

    for (int x = 0; x < distinctOrdresDatePerMonth.length; x++) {
      // Get all ordres for specific Day
      numOfOrdersPermonth = ordersPerMonth
          .where((e) =>
              DateFormat.MMM().format(DateTime.parse(e['createdAt'])) ==
              distinctOrdresDatePerMonth[x])
          .toList();

      // Quantity of Orders per Month for Year
      numOfOrdersPerYear.add(numOfOrdersPermonth.length);
    }
  }

  calcOrdersPerDay() {
    List ordersDate = [];

    for (int i = 0; i < ordersPerDay.length; i++) {
      // Get All Orders Date
      ordersDate.add(DateFormat.yMd()
          .format(DateTime.parse(ordersPerDay[i]['createdAt'])));

      // Remove Duplicate Dates
      distinctOrdresDatePerDay = ordersDate.toSet().toList();
    }

    for (int x = 0; x < distinctOrdresDatePerDay.length; x++) {
      // Get all ordres for specific Day
      numOfOrdersPerDay = ordersPerDay
          .where((e) =>
              DateFormat.yMd().format(DateTime.parse(e['createdAt'])) ==
              distinctOrdresDatePerDay[x])
          .toList();

      // Quantity of Orders per Day for Month
      ordersPerAllMonth.add(numOfOrdersPerDay.length);
    }
  }

  changeChart(int? value) {
    selectedChart = value;
    update();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

// const socket = io("https://dashboard-api-lrnu.onrender.com", {
//   auth: {
//     token,
//   },
// });

// socket.on("connect", () => {
//   console.log("Connected to server");
//   document.getElementById("socketConnect").textContent = "Socket connected";
// });

// socket.on("orderAdded", (order) => {
//   console.log(order: ${JSON.stringify(order)});
//   // use the order doc here
//   //
//   document.getElementById("socketEventAdded").textContent = "Order Added";
// });
