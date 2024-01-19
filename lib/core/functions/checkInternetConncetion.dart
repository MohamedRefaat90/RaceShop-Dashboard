import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

String knownUrl = "www.google.com";
Future<bool> checkInternetConnection() async {
  if (kIsWeb) {
    return _hasNetworkWeb(knownUrl);
  } else {
    return _hasNetworkMobile(knownUrl);
  }
}

Future<bool> _hasNetworkWeb(String knownUrl) async {
  try {
    final result = await Dio().get(knownUrl);
    if (result.statusCode == 200) return true;
  } on SocketException catch (_) {}
  return false;
}

Future<bool> _hasNetworkMobile(String knownUrl) async {
  try {
    final result = await InternetAddress.lookup(knownUrl);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {}
  return false;
}
