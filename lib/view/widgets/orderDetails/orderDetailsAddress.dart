import 'package:dashboard/core/constants/AppAssets.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_io/io.dart';

import 'package:dashboard/controller/orderDetails/orderDetailsController.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../controller/Home/HomeController.dart';

class OrderDetailsAddress extends GetView<orderDetailsController> {
  const OrderDetailsAddress({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(orderDetailsController());
    HomeController homeController = Get.find();
    return DefaultTextStyle(
      style: TextStyle(
          color: homeController.isDarkMode ? AppColors.white : AppColors.black,
          fontSize: 18),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 3),
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 10)
              .copyWith(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("DeliveryDetails".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(height: 10),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Street:'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${controller.order.address!.street}'),
              ])),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Building:'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${controller.order.address!.buildingNumber}'),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Floor:'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${controller.order.address!.floorNumber}'),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Apartment:'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '${controller.order.address!.apartmentNumber}'),
                ])),
              ]),
              const SizedBox(height: 5),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Zone:'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${controller.order.address!.city}'),
              ])),
              const SizedBox(height: 5),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'DeliveyTime:'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "within".tr),
                TextSpan(text: "${controller.order.delevieryTimeInDays}"),
                TextSpan(text: "days".tr),
              ])),
              const SizedBox(height: 15),
              Container(
                height: 200,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                      initialCenter: LatLng(
                          controller.order.address!.coordinates![1],
                          controller.order.address!.coordinates![0])),
                  children: [
                    TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app'),
                    MarkerLayer(
                      markers: [
                        Marker(
                            point: LatLng(
                                controller.order.address!.coordinates![1],
                                controller.order.address!.coordinates![0]),
                            width: 40,
                            height: 40,
                            child: SvgPicture.asset(AppAssets.locationMarker,
                                color: Colors.red))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
