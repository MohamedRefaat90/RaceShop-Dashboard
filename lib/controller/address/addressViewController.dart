import 'package:get/get.dart';

import '../../core/class/statusRequest.dart';
import '../../core/functions/handelDataController.dart';
import '../../core/services/myServices.dart';
import '../../data/Model/DeliveryZoneModel.dart';
import '../../data/Model/userModel.dart';
import '../../data/dataSource/remote/Address/AddressData.dart';

class AddressViewController extends GetxController {
  AddressData addressData = AddressData(Get.find());
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  late String userToken;
  List addressList = [];

  @override
  void onInit() {
    userToken = myServices.sharedPreferences.getString("userToken")!;
    getAllAddresses();

    super.onInit();
  }

  getAllAddresses() async {
    addressList.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await addressData.getAddress(userToken);

    statusRequest = handelData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        var responseData = response['data']['data']['address'];

        addressList.addAll(responseData.map((e) => AddressModel.fromJson(e)));
        update();
      }
    }

    update();
  }
}
