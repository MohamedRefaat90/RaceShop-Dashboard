import 'package:dashboard/view/screens/Home/homeScreen.dart';

import 'package:dashboard/view/screens/Login/login.dart';

import 'package:dashboard/view/screens/categoryProductsScreen/categoryProducts.dart';

import 'package:dashboard/view/screens/Products/productDetails.dart';
import 'package:dashboard/view/test.dart';
import 'package:get/get.dart';
import 'core/constants/AppRoutes.dart';
import 'view/screens/CategoriesScreen/CategoriesScreen.dart';
import 'view/screens/Notifications/NotificationsScreen.dart';
import 'view/screens/OrdersScreen/OrdersScreen.dart';

import 'view/screens/orderDetails/OrderDetailsScreen.dart';

List<GetPage<dynamic>>? routes = [
  // ===================== Login =====================
  GetPage(name: AppRoutes.login, page: () => const Login()),

  // ===================== Home =====================
  GetPage(name: AppRoutes.home, page: () => const HomeScreen()),

  // ===================== Categories =====================
  GetPage(name: AppRoutes.categories, page: () => const CategoriesScreen()),

  // ===================== Categories =====================
  GetPage(
      name: AppRoutes.categoryProducts, page: () => const CategoryProducts()),

// ================= Orders =================
  GetPage(name: AppRoutes.orders, page: () => const OrdersScreen()),

// ================= Orders Details=================
  GetPage(
      name: AppRoutes.ordersDetails,
      page: () => const OrderDetailsScreen(),
      transition: Transition.zoom),

// ================= Notifications =================
  GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.downToUp),

// ================= test =================
  GetPage(name: AppRoutes.test, page: () => const Test()),
];
