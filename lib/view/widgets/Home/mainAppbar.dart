import 'package:dashboard/controller/Login/login.dart';
import 'package:dashboard/core/constants/AppColors.dart';
import 'package:dashboard/core/functions/ThemeColorFix.dart';
import 'package:dashboard/core/services/myServices.dart';
import 'package:dashboard/data/Model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/Home/HomeController.dart';
import '../../../controller/search/searchController.dart';
import '../../../core/constants/AppAssets.dart';
import '../../../core/shared/customField.dart';
import 'SettingsButton.dart';

class mainAppbar extends GetView<HomeController> {
  const mainAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    SearchBarController searchController = Get.put(SearchBarController());
    SharedPreferences adminData = Get.find<MyServices>().sharedPreferences;
    return GetBuilder<LoginControllerImp>(builder: (context) {
      return DefaultTextStyle(
        style: TextStyle(color: ThemeColorFix()),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                          children: [
                            TextSpan(text: "welcome".tr),
                            TextSpan(text: adminData.getString("fName")),
                          ],
                          style: const TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                      Text("AppbarDesc".tr)
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0)
                      .copyWith(left: 3, right: 0),
                  child: TextField(
                    controller: searchController.searchController,
                    onChanged: (value) {
                      searchController.checkSearch(value.isEmpty);
                    },
                    onSubmitted: (value) {
                      searchController.isSearching();
                      searchController.getSearchedData(
                          searchedWord: searchController.searchController.text);
                    },
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        // hintText: "findProduct".tr,
                        hintText: "search".tr,
                        hintStyle: TextStyle(color: ThemeColorFix()),
                        prefixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        suffixIcon: searchController.isSearch
                            ? IconButton(
                                onPressed: () {
                                  searchController.clearSearch();
                                  homeController.changePage(0);
                                },
                                icon:
                                    const Icon(Icons.cancel, color: Colors.red))
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: AppColors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // InkWell(
                      //   onTap: () {},
                      //   borderRadius: BorderRadius.circular(100),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: SvgPicture.asset(AppAssets.notifications,
                      //         width: 40, color: ThemeColorFix()),
                      //   ),
                      // ),
                      // const SizedBox(width: 10),
                      CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(AppAssets.logo)),
                      Text(
                          "${adminData.getString("fName")} ${adminData.getString("lName")}"),
                      const SettingsButton()
                    ],
                  ))
            ]),
      );
    });
  }
}
