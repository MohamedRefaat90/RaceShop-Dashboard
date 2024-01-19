import 'package:dashboard/ApiLinks.dart';
import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/core/class/DB_helper.dart';

class DelevieryZoneData {
  DB_helper db_helper;

  DelevieryZoneData(this.db_helper);

  createZone({String? userToken, required Map data}) async {
    var response = await db_helper.postData(ApiLinks.deliveryZone, data,
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  getZone({String? userToken}) async {
    var response =
        await db_helper.getAllData(ApiLinks.deliveryZone, userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  updateZone(
      {required String zoneID, String? userToken, required Map data}) async {
    var response = await db_helper.patchData(
        "${ApiLinks.deliveryZone}/$zoneID", data,
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  deleteZone({String? userToken, required String zoneID}) async {
    var response = await db_helper.deleteData(
        "${ApiLinks.deliveryZone}/$zoneID", userToken!);

    return response.fold((l) => l, (r) => r);
  }
}
