import 'package:dashboard/ApiLinks.dart';
import 'package:dashboard/core/class/DB_helper.dart';

import '../../../../controller/Login/login.dart';

class UserData {
  DB_helper db_helper;

  UserData(this.db_helper);

  getUserData(String userToken) async {
    var response =
        await db_helper.getAllData(ApiLinks.user, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  updateUserData(String userToken, Map data) async {
    var response =
        await db_helper.patchData(ApiLinks.user, data, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }
}
