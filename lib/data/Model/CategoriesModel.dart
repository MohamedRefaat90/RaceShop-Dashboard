class CategoriesModel {
  String? categoryID;
  String? categoryName;
  String? categoryNameAr;
  String? categoryImage;
  String? categoryCreatedAt;
  String? categoryUpdatedAt;
  int? categoryV;

  CategoriesModel(
      {required this.categoryID,
      required this.categoryName,
      required this.categoryNameAr,
      required this.categoryImage,
      required this.categoryCreatedAt,
      required this.categoryUpdatedAt,
      required this.categoryV});

  factory CategoriesModel.fromJson(Map jsonData) {
    return CategoriesModel(
        categoryID: jsonData['_id'],
        categoryName: jsonData['name'],
        categoryNameAr: jsonData['name_ar'],
        categoryImage: jsonData['image'],
        categoryCreatedAt: jsonData['createdAt'],
        categoryUpdatedAt: jsonData['updatedAt'],
        categoryV: jsonData['__v']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['_id'] = categoryID;
    data['name'] = categoryName;
    data['name_ar'] = categoryNameAr;
    data['image'] = categoryImage;
    data['createdAt'] = categoryCreatedAt;
    data['updatedAt'] = categoryUpdatedAt;
    data['__v'] = categoryV;

    return data;
  }
}
