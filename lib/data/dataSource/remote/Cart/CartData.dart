import 'package:dashboard/ApiLinks.dart';
import 'package:dashboard/core/class/DB_helper.dart';

class CartData {
  DB_helper dB_helper;

  CartData(this.dB_helper);

  getCartProducts(String userToken) async {
    var resposne =
        await dB_helper.getAllData(ApiLinks.cart, userToken: userToken);

    return resposne.fold((l) => l, (r) => r);
  }

  addToCart(
      {required String productID,
      required String productName,
      required String productDesc,
      required String img,
      required int quantity,
      required String color,
      required String size,
      required String userToken}) async {
    var response = await dB_helper.postData(
        ApiLinks.cart,
        {
          "item": {
            "product": productID,
            "productName": productName,
            "productDescription": productDesc,
            "coverImage": img,
            "selectedVariation": {"color": color, "size": size},
            "quantity": quantity
          }
        },
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }

  removeOneFromCart(String productID, String userToken) async {
    var response = await dB_helper.patchData(
        "${ApiLinks.removeFromCart}$productID", {},
        userToken: userToken);
    return response.fold((l) => l, (r) => r);
  }

  removeFromCart(String productID, String userToken) async {
    var response = await dB_helper.patchData(
        "${ApiLinks.removeFromCart}$productID?deleteItem=true", {},
        userToken: userToken);
    return response.fold((l) => l, (r) => r);
  }

  getProductData(String productID, String userToken) async {
    var response = await dB_helper.getAllData("${ApiLinks.product}/$productID",
        userToken: userToken);

    return response.fold((l) => l, (r) => r);
  }
}
