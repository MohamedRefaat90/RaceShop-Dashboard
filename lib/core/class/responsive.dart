import 'package:flutter/material.dart';

class Responsive {
  static Size getSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size;
  }
}
