import 'package:dashboard/ApiLinks.dart';
import 'package:dashboard/core/class/DB_helper.dart';

class LoginData {
  DB_helper db_helper;

  LoginData(this.db_helper);

  login({required String email, required String password}) async {
    var response = await db_helper
        .login(ApiLinks.login, {"email": email, 'password': password});

    return response.fold((l) => l, (r) => r);
  }

  logout(String userToken) async {
    var response =
        await db_helper.postData(ApiLinks.logout, {}, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }
}
