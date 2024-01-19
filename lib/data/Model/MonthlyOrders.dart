import 'package:intl/intl.dart';

import 'DailyOrders.dart';

class MonthlyOrders extends DailyOrders {
  List monthes = [
    "Jan",
    "Fab",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  String? month;
  @override
  int? numOfOrders;

  MonthlyOrders({this.month, this.numOfOrders});

  getMonthlyOrders({required List numOforders, required List ordersDates}) {
    List<MonthlyOrders> monthlyOrders = [];

    int j = 0;
    outer:
    for (int i = 0; i < monthes.length; i++) {
      if (j < ordersDates.length) {
        for (;;) {
          if (ordersDates[j] == monthes[i]) {
            monthlyOrders.add(
                MonthlyOrders(month: monthes[i], numOfOrders: numOforders[j]));
            j++;
            continue outer;
          } else {
            monthlyOrders.add(MonthlyOrders(month: monthes[i], numOfOrders: 0));
            continue outer;
          }
        }
      } else {
        monthlyOrders.add(MonthlyOrders(month: monthes[i], numOfOrders: 0));
        continue outer;
      }
    }

    return monthlyOrders;
  }
}
