import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/core/constants/AppAssets.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';

import 'package:dashboard/core/functions/validateInputs.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/shared/BTN.dart';
import '../../../core/shared/HandleingRequsetData.dart';
import '../../../core/shared/customField.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());

    return Scaffold(
      // backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
        child: GetBuilder<LoginControllerImp>(builder: (controller) {
          return HandleingRequsetData(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                  child: Form(
                      key: controller.formkey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width * 0.3),
                        child: Column(children: [
                          Image.asset(AppAssets.logo, width: 230),
                          const Text("RaceShop Dashboard",
                              style: TextStyle(fontSize: 30)),
                          const SizedBox(height: 30),
                          customField(
                              validator: (value) {
                                return ValidateInputs(
                                    value!.trim(), "email", 5, 30);
                              },
                              textEditingController: controller.email,
                              lable: 'email'.tr,
                              icon: Icons.email_outlined,
                              hint: "enterEmail".tr),
                          const SizedBox(height: 20),
                          GetBuilder<LoginControllerImp>(builder: (context) {
                            return customField(
                                validator: (value) {
                                  return ValidateInputs(
                                      value!.trim(), "password", 8, 30);
                                },
                                textEditingController: controller.password,
                                isPass: controller.visibility,
                                isTextArea: false,
                                lable: 'password'.tr,
                                icon: !controller.visibility
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                iconPress: () => controller.passVisible(),
                                hint: "enterPass".tr);
                          }),
                          const SizedBox(height: 20),
                          BTN(
                              widget: Text('login'.tr),
                              press: () {
                                controller.login();
                              },
                              width: 200)
                        ]),
                      ))));
        }),
      ),
    );
  }
}
