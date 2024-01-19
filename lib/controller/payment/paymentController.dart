import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class paymantController extends GetxController {
  late String paymentURL;

  late WebViewController webViewController;

  @override
  void onInit() {
    paymentURL = Get.arguments;

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(paymentURL));

    super.onInit();
  }
}
