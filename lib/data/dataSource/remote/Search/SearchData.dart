import 'package:dartz/dartz.dart';

import 'package:dashboard/core/class/statusRequest.dart';

import '../../../../ApiLinks.dart';
import '../../../../controller/Login/login.dart';
import '../../../../core/class/DB_helper.dart';

class SearchData {
  DB_helper db_helper;
  SearchData(this.db_helper);

  getSearchedData(String userToken, {required String searchedWord}) async {
    List<Either<StatusRequest, Map>> response;

    response = await Future.wait([
      db_helper.getAllData("${ApiLinks.orders}/$searchedWord",
          userToken: userToken),
      db_helper.getAllData("${ApiLinks.product}?search=$searchedWord",
          userToken: userToken)
    ]);

    if (response[0] == Right) {
      return response[0];
    } else {
      return response[1];
    }
  }
}
