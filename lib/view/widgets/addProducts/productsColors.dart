import 'package:dashboard/core/constants/AppAssets.dart';
import 'package:dashboard/core/shared/BTN.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/shared/customField.dart';

class productsColors extends GetView<CategoryProductsControllerImp> {
  const productsColors({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return GetBuilder<CategoryProductsControllerImp>(builder: (context) {
      return Visibility(
        visible: controller.showColors,
        child: Row(
          children: [
            Text("Colors:".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: homeController.isDarkMode
                        ? AppColors.white
                        : AppColors.black)),
            const SizedBox(width: 20),
            ...List.generate(
                controller.colorsName.length,
                (index) => InkWell(
                      onTap: () {
                        controller.changeSelectedColor(index);
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: controller.colors[index],
                            border: controller.selectedColorIndex == index
                                ? Border.all(color: Colors.purple, width: 5)
                                : null),
                      ),
                    )),
            const SizedBox(width: 30),
            SizedBox(
              width: controller.textFiledWidth,
              child: Form(
                key: controller.quantityFormkey,
                child: customField(
                  lable: "Quantity".tr,
                  textEditingController: controller.quantity,
                  validator: (value) {
                    if (!GetUtils.isNumericOnly(value!)) {
                      return "Only Numbers";
                    } else if (value.isEmpty) {
                      return "Can't be Empty";
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(width: 30),
            BTN(
                widget: Text("add".tr),
                width: 100,
                press: () {
                  if (controller.quantityFormkey.currentState!.validate()) {
                    controller.addVariation();
                  }
                }),
            const SizedBox(width: 10),
            GetBuilder<CategoryProductsControllerImp>(builder: (context) {
              return AnimatedSlide(
                  duration: const Duration(milliseconds: 700),
                  offset: Offset(0, controller.isVariationAdded ? 0 : 20),
                  child: AnimatedOpacity(
                      opacity: controller.isVariationAdded ? 1 : 0,
                      duration: const Duration(milliseconds: 700),
                      child: SvgPicture.asset(AppAssets.done, width: 30)));
            })
          ],
        ),
      );
    });
  }
}
