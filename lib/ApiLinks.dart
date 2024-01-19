class ApiLinks {
  // Auth API
  static const String baseURL = "https://ecommerce-api-lrnu.onrender.com";

  // ==================== Auth ============================
  // static const String signup = "$baseURL/api/v1/auth/signup";
  static const String login = "$baseURL/api/v1/auth/login";
  // static const String forgotPassword = "$baseURL/api/v1/auth/forgotPassword";
  // static const String resetPassword = "$baseURL/api/v1/auth/resetPassword";
  // static const String confirmEmail = "$baseURL/api/v1/auth/confirmEmail";
  // static const String resendOtp = "$baseURL/api/v1/auth/resendOtp";
  static const String logout = "$baseURL/api/v1/auth/logout";

  // ==================== Categories ============================
  static const String category = "$baseURL/api/v1/category";
  static const String deleteCategory =
      "$baseURL/api/v1/category/64ba62753664a7357c4672a8";
  static const String updateCategory =
      "$baseURL/api/v1/category/64ba65d699953c0032ac0894";

  // ==================== Products ============================
  static const String product = "$baseURL/api/v1/product";

  // ==================== Cart ============================
  static const String cart = "$baseURL/api/v1/cart";
  static const String removeFromCart = "$baseURL/api/v1/cart/item/";

  // ==================== User ============================
  static const String user = "$baseURL/api/v1/users/me";
  static const String addAddress = "$baseURL/api/v1/users/address";
  static const String removeAddess = "$baseURL/api/v1/users/address";

  // ==================== Coupon ============================
  static const String varifyCoupon = "$baseURL/api/v1/coupons/verify?name=";

  // ==================== DeliveryZone ============================
  static const String deliveryZone = "$baseURL/api/v1/delevieryZone";

  // ==================== Orders ============================
  static const String orders = "$baseURL/api/v1/order";

  // ==================== Orders ============================
  static const String deleiveryZone = "$baseURL/api/v1/delevieryZone";
}
