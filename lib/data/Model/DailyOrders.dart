import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

class DailyOrders {
  int? day;
  int? numOfOrders;
  static List<int> daysPerMonth = [];

  DailyOrders({this.day, this.numOfOrders});

  static calcDaysinMonth() {
    int numofDaysPerMonth =
        daysInMonth(DateTime.now().year, DateTime.now().month);

    for (int i = 1; i <= numofDaysPerMonth; i++) {
      daysPerMonth.add(i);
    }
  }

  getDailyOrders({required List numOforders, required List ordersDates}) {
    List<DailyOrders> dailyOrders = [];

    int j = 0;

    outer:
    for (int i = 0; i < daysPerMonth.length; i++) {
      if (j < ordersDates.length) {
        for (;;) {
          if (DateFormat.yMd().parse(ordersDates[j]).day == daysPerMonth[i]) {
            dailyOrders.add(
                DailyOrders(day: daysPerMonth[i], numOfOrders: numOforders[j]));
            j++;
            continue outer;
          } else {
            dailyOrders.add(DailyOrders(day: daysPerMonth[i], numOfOrders: 0));
            continue outer;
          }
        }
      } else {
        dailyOrders.add(DailyOrders(day: daysPerMonth[i], numOfOrders: 0));
        continue outer;
      }
    }

    return dailyOrders;
  }
}
