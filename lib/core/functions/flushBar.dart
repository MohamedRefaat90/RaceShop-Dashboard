import 'package:another_flushbar/flushbar.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:flutter/material.dart';

flushBar(BuildContext context,
    {String? message, StatusRequest? status, Color? color}) {
  Flushbar(
    titleSize: 18,
    backgroundColor: status == StatusRequest.success
        ? Colors.green
        : status == StatusRequest.offlineFailure
            ? Colors.black87
            : color!,
    message: status == StatusRequest.offlineFailure
        ? "You Are not Conneted To Internet"
        : message ?? status.toString(),
    messageSize: 16,
    duration: const Duration(seconds: 4),
  ).show(context);
}
