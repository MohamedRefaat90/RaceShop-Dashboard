import 'package:dashboard/Bindings/myBindings.dart';
import 'package:dashboard/controller/Home/HomeController.dart';
import 'package:dashboard/core/constants/AppRoutes.dart';
import 'package:dashboard/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/localization/transilation.dart';
import 'core/services/myServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(builder: (controller) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: MyTransilation(),
          theme: controller.mainTheme,
          locale: controller.locale,
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: controller.themeMode,
          initialBinding: myBindings(),
          initialRoute: AppRoutes.login,
          getPages: routes);
    });
  }
}
