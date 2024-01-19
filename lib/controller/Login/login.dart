import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/constants/AppRoutes.dart';
import 'package:dashboard/core/functions/toast.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/data/Model/userModel.dart';
import 'package:dashboard/data/dataSource/remote/Auth/loginData.dart';
import 'package:dashboard/data/dataSource/remote/user/userData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/handelDataController.dart';

abstract class LoginController extends GetxController {
  login();
  passVisible();
  logout();
}

class LoginControllerImp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visibility = true;
  var testConnection;
  MyServices myServices = Get.find();
  late String userToken;
  LoginData loginData = LoginData(Get.find());
  UserData userData = UserData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  late userModel? user;
  @override
  void onInit() async {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  login() async {
    var fromdata = formkey.currentState;

    if (fromdata!.validate()) {
      {
        statusRequest = StatusRequest.loading;
        update();
        var response = await loginData.login(
            email: email.text.trim(), password: password.text);

        statusRequest = handelData(response);

        if (statusRequest == StatusRequest.success) {
          myServices.sharedPreferences
              .setString("userToken", response['token']);

          userToken = myServices.sharedPreferences.getString("userToken")!;

          await getAdminData();
          // Get.offNamed(AppRoutes.home);
        } else {
          Get.offAllNamed(AppRoutes.login);
          toastAlert(
              msg: "user or paswword not Correct try again", color: Colors.red);
        }
      }
    }
    update();
  }

  getAdminData() async {
    var response = await userData.getUserData(userToken);
    statusRequest = handelData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        user = userModel.fromJson(response['data']['data']);
        myServices.sharedPreferences.setString("fName", user!.firstName!);
        myServices.sharedPreferences.setString("lName", user!.lastName!);
        Get.offAllNamed(AppRoutes.home);
      }
    }
  }

  @override
  passVisible() {
    visibility = !visibility;
    update();
  }

  @override
  logout() {
    loginData.logout(myServices.sharedPreferences.getString('userToken')!);

    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
