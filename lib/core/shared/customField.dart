import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Home/HomeController.dart';

class customField extends StatelessWidget {
  const customField(
      {super.key,
      this.lable,
      this.icon,
      this.hint,
      this.textEditingController,
      this.isPass = false,
      this.isPhone = false,
      this.iconPress,
      this.validator,
      this.initialValue,
      this.isTextArea = false});
  final String? lable;
  final String? hint;
  final String? initialValue;
  final IconData? icon;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final Function()? iconPress;
  final bool isPass;
  final bool isPhone;
  final bool? isTextArea;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return TextFormField(
        controller: textEditingController,
        validator: validator,
        initialValue: initialValue,
        obscureText: isPass,
        maxLines: isTextArea! ? 7 : 1,
        keyboardType: isTextArea! ? TextInputType.multiline : null,
        style: TextStyle(color: ThemeColorFix()),
        decoration: InputDecoration(
            label: Text(lable ?? ""),
            labelStyle: const TextStyle(color: AppColors.primaryColor),
            hintText: hint,
            hintStyle: const TextStyle(fontWeight: FontWeight.w100),
            errorStyle:
                const TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            suffixIconColor: AppColors.primaryColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(
                // borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: homeController.isDarkMode
                        ? AppColors.white
                        : AppColors.black),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            suffixIcon: IconButton(
                icon: Icon(icon, color: AppColors.primaryColor),
                onPressed: iconPress)));
  }
}
