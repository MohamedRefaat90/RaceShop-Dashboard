import 'package:get/get.dart';

import '../core/class/DB_helper.dart';

class myBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DB_helper());
  }
}
