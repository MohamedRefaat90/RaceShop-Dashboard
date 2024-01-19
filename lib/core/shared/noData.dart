import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/AppAssets.dart';

class noData extends StatelessWidget {
  const noData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAssets.noData));
  }
}
