class CouponModel {
  String? sId;
  String? name;
  int? quantity;
  int? discount;
  String? expirationDate;
  String? createdAt;
  String? updatedAt;

  CouponModel(
      {this.sId,
      this.name,
      this.quantity,
      this.discount,
      this.expirationDate,
      this.createdAt,
      this.updatedAt});

  CouponModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    quantity = json['quantity'];
    discount = json['discount'];
    expirationDate = json['expirationDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['expirationDate'] = this.expirationDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
