import 'package:dashboard/core/class/statusRequest.dart';

handelData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
