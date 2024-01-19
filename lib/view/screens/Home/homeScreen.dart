import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/class/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/Login/login.dart';
import '../../widgets/Home/mainAppbar.dart';
import '../../widgets/Home/sidebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp login = Get.put(LoginControllerImp());
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          backgroundColor: controller.isDarkMode
              ? null
              : const Color.fromARGB(255, 248, 247, 252),
          resizeToAvoidBottomInset: true,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const sidebar(),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(30.0).copyWith(right: 10),
                  child: const SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [mainAppbar(), SizedBox(height: 20), body()]),
                  ),
                ),
              )
            ],
          ));
    });
  }
}

class body extends StatelessWidget {
  const body({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
          height: Responsive.getSize(context).height * 0.8,
          width: Responsive.getSize(context).width,
          color: controller.isDarkMode
              ? null
              : const Color.fromARGB(255, 248, 247, 252),
          child: controller.pages[controller.selectedPage]
          // child: controller.pages[1],
          );
    });
  }
}
