import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CategoryProducts/CategoryProductsController.dart';
import '../../../controller/product/ProductController.dart';
import '../../../core/shared/customField.dart';

class productBasicInfo extends GetView<ProductDetailsControllerImp> {
  const productBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          SizedBox(
            width: controller.textFiledWidth,
            child: customField(
              lable: "ProductName".tr,
              textEditingController: controller.editproductName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Can't be Empty";
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: controller.textFiledWidth,
            child: customField(
                lable: "ProductNameAr".tr,
                textEditingController: controller.editproductNameAr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't be Empty";
                  }
                  return null;
                }),
          )
        ]),
        const SizedBox(height: 15),
        Row(children: [
          SizedBox(
            width: 350,
            child: customField(
              lable: "ProductDesc".tr,
              isTextArea: true,
              textEditingController: controller.editproductDesc,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 350,
            child: customField(
              lable: "ProductDescAr".tr,
              isTextArea: true,
              textEditingController: controller.editproductDescAr,
            ),
          )
        ]),
        const SizedBox(height: 15),
        Row(
          children: [
            SizedBox(
              width: controller.textFiledWidth,
              child: customField(
                lable: "Price".tr,
                textEditingController: controller.editprice,
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
            const SizedBox(width: 20),
            SizedBox(
              width: controller.textFiledWidth,
              child: customField(
                lable: "Discount%".tr,
                textEditingController: controller.editdiscount,
                validator: (value) {
                  if (!GetUtils.isNumericOnly(value!)) {
                    return "Only Numbers";
                  } else if (value.isEmpty) {
                    return "Can't be Empty";
                  }
                  return null;
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
