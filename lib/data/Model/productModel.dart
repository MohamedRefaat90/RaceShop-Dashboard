// ignore_for_file: public_member_api_docs, sort_constructors_first
class productModel {
  String productID;
  String productName;
  String productNameAr;
  String productDesc;
  String productDescAr;
  List productImages;
  bool productActive;
  int productDiscount;
  bool? productIsFav;
  // String productColor;
  // String productSize;
  int productPrice;
  // String productDate;
  String productCoverImage;
  String productCreatedAt;
  String productUpdatedAt;
  int productV;
  List productVariations;
  Map? productVariationsBySize;
  // double productRatingsAverage;
  // int productRatingsQuantity;
  String categoryID;
  String categoryName;
  String categoryNameAr;

  String categoryCreatedAt;
  String categoryUpdatedAt;
  int categoryV;
  productModel({
    required this.productID,
    required this.productName,
    required this.productNameAr,
    required this.productDesc,
    required this.productDescAr,
    required this.productImages,
    required this.productActive,
    required this.productDiscount,
    required this.productIsFav,
    // required this.productColor,
    // required this.productSize,
    required this.productPrice,
    // required this.productDate,
    required this.productCoverImage,
    required this.productCreatedAt,
    required this.productUpdatedAt,
    required this.productV,
    required this.productVariations,
    required this.productVariationsBySize,
    // required this.productRatingsAverage,
    // required this.productRatingsQuantity,
    required this.categoryID,
    required this.categoryName,
    required this.categoryNameAr,
    required this.categoryCreatedAt,
    required this.categoryUpdatedAt,
    required this.categoryV,
  });

  factory productModel.formjson(Map jsonData) {
    return productModel(
      productID: jsonData['_id'],
      productName: jsonData['name'],
      productNameAr: jsonData['name_ar'],
      productDesc: jsonData['description'],
      productDescAr: jsonData['description_ar'],
      productImages: jsonData['images'],
      productActive: jsonData['active'],
      productIsFav: jsonData['favourite'],
      productPrice: jsonData['price'],
      productDiscount: jsonData['discount'],
      productCreatedAt: jsonData['createdAt'],
      productUpdatedAt: jsonData['updatedAt'],
      // productRatingsAverage: jsonData['ratingsAverage'],
      // productRatingsQuantity: jsonData['ratingsQuantity'],
      categoryID: jsonData['_id'],
      categoryName: jsonData['name'],
      categoryNameAr: jsonData['name_ar'],
      categoryCreatedAt: jsonData['createdAt'],
      categoryUpdatedAt: jsonData['updatedAt'],
      categoryV: jsonData['__v'],
      productVariations: jsonData['variations'],
      productVariationsBySize: jsonData['variationsBySize'],
      productCoverImage: jsonData['coverImage'],
      productV: jsonData['__v'],
    );
  }

  toJson() {
    Map<String, dynamic> data = {};
    data['data']['data']['images'] = productImages;
    data['data']['data']['discount'] = productDiscount;
    data['data']['data']['active'] = productActive;
    data['data']['data']['_id'] = productID;
    data['data']['data']['name'] = productName;
    data['data']['data']['name_ar'] = productNameAr;
    data['data']['data']['favourite'] = productIsFav;
    data['data']['data']['description'] = productDesc;
    data['data']['data']['description_ar'] = productDescAr;
    data['data']['data']['category'] = categoryID;
    data['data']['data']['price'] = productPrice;
    data['data']['data']['variations'] = productVariations;
    data['data']['data']['variationsBySize'] = productVariationsBySize;
    data['data']['data']['coverImage'] = productCoverImage;
    data['data']['data']['createdAt'] = productCreatedAt;
    data['data']['data']['updatedAt'] = productUpdatedAt;
    data['data']['data']['__v'] = productV;

    return data;
  }
}
