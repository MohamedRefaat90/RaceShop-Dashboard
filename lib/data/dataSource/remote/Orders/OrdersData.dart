import 'package:dashboard/controller/Login/login.dart';
import 'package:intl/intl.dart';

import '../../../../ApiLinks.dart';
import '../../../../core/class/DB_helper.dart';

class OrdersData {
  final DB_helper db_helper;

  OrdersData(this.db_helper);

  getAllOrders({required String userToken}) async {
    var response = await db_helper.getAllData(
        "${ApiLinks.orders}?limit=1000000&sort=desc&sortBy=createdAt",
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  getOrdersPerMonth({required String userToken}) async {
    DateTime minData = DateTime.utc(DateTime.now().year, DateTime.january, 1);
    DateTime maxData = DateTime.utc(DateTime.now().year, DateTime.december, 30);

    var response = await db_helper.getAllData(
        "${ApiLinks.orders}?limit=10000000000&minDate=$minData&maxDate=$maxData",
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  getOrdersPerDay({required String userToken}) async {
    DateTime firstDayCurrentMonth =
        DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

    DateTime lastDayCurrentMonth =
        DateTime.utc(DateTime.now().year, DateTime.now().month + 1)
            .subtract(const Duration(days: 1));

    String minData =
        DateFormat.yMd('en_US').format(firstDayCurrentMonth).toString();
    String maxData =
        DateFormat.yMd('en_US').format(lastDayCurrentMonth).toString();

    var response = await db_helper.getAllData(
        "${ApiLinks.orders}?limit=10000000000&minDate=$minData&maxDate=$maxData&sort=aesc&sortBy=createdAt",
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  cancelOrder(String orderID, String userToken) async {
    var response = await db_helper.postData(
        "${ApiLinks.orders}/cancel/$orderID", {},
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  getCompeltedOrders(String userToken) async {
    var response = await db_helper.getAllData(
        "${ApiLinks.orders}?page=1&limit=20&sort=desc&status=completed",
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  changeOrderStatus(String orderID, String status, String userToken) async {
    var response = await db_helper.patchData(
        "${ApiLinks.orders}/$orderID", {"status": status},
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }
}
