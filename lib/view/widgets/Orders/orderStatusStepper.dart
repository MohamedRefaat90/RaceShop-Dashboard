import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/orders/ordersController.dart';
import '../../../core/constants/AppColors.dart';

class orderStatusStepper extends StatelessWidget {
  const orderStatusStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ordersController>(builder: (controller) {
      return EasyStepper(
        activeStep: controller.activeStep!,
        stepShape: StepShape.rRectangle,
        stepBorderRadius: 15,
        borderThickness: 2,
        padding: EdgeInsets.all(15),
        stepRadius: 28,
        finishedStepBorderColor: Colors.deepOrange,
        // finishedStepTextColor: Colors.deepOrange,
        finishedStepBackgroundColor: AppColors.primaryColor,
        finishedStepIconColor: AppColors.white,
        activeStepIconColor: Colors.deepOrange,
        showLoadingAnimation: false,
        steps: [
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: controller.activeStep! >= 0 ? 1 : 0.3,
                child: SvgPicture.asset("assets/icons/waiting.svg",
                    width: 35,
                    color: controller.activeStep! > 0
                        ? AppColors.white
                        : AppColors.black),
              ),
            ),
            customTitle: const Text('Pending', textAlign: TextAlign.center),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: controller.activeStep! >= 1 ? 1 : 0.3,
                child: SvgPicture.asset("assets/icons/shipping.svg",
                    width: 35,
                    color: controller.activeStep! > 1
                        ? AppColors.white
                        : AppColors.black),
              ),
            ),
            customTitle: const Text('On The Way', textAlign: TextAlign.center),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: controller.activeStep! >= 2 ? 1 : 0.3,
                child: SvgPicture.asset("assets/icons/Delivered.svg",
                    width: 35,
                    color: controller.activeStep! > 2
                        ? AppColors.white
                        : AppColors.black),
              ),
            ),
            customTitle: const Text('Delivered', textAlign: TextAlign.center),
          ),
        ],
        onStepReached: (index) => controller.activeStep = index,
      );
    });
  }
}
