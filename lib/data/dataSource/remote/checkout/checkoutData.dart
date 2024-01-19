// import '../../../../ApiLinks.dart';
// import '../../../../core/class/DB_helper.dart';

// class CheckoutData {
//   DB_helper db_helper;

//   CheckoutData(this.db_helper);

//   makeCheckoutCash(
//       {required String AddressID,
//       required String DelevieryZoneId,
//       required String? couponName,
//       required String userToken}) async {
//     var response = await db_helper.postData(
//         ApiLinks.checkout,
//         {
//           "paymentMethod": "cash",
//           "addressId": AddressID,
//           "delevieryZoneId": DelevieryZoneId,
//           "couponName": couponName
//         },
//         userToken: userToken);

//     return response.fold((l) => l, (r) => r);
//   }

//   makeCheckoutOnline(
//       {required String AddressID,
//       required String DelevieryZoneId,
//       required String couponName,
//       required String mobileWallet,
//       required String paymentMethodType,
//       required String userToken}) async {
//     var response = await db_helper.postData(
//         ApiLinks.checkout,
//         {
//           "paymentMethod": "online",
//           "paymentMethodType": paymentMethodType,
//           "addressId": AddressID,
//           "mobileNumber": mobileWallet,
//           "delevieryZoneId": DelevieryZoneId,
//           "couponName": couponName
//         },
//         userToken: userToken);

//     return response.fold((l) => l, (r) => r);
//   }

//   ConfirmOrder(String preCheckoutID, String userToken) async {
//     var response = await db_helper.postData(
//         "${ApiLinks.checkout}/$preCheckoutID", {},
//         userToken: userToken);

//     return response.fold((l) => l, (r) => r);
//   }
// }
