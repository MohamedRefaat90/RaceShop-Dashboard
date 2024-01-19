class DeliveryZoneModel {
  String? id;
  String? zoneNameEn;
  String? zoneNameAr;
  int? delevieryFee;
  int? delevieryTimeInDays;
  String? createdAt;
  String? updatedAt;
  int? iV;

  DeliveryZoneModel(
      {this.id,
      this.zoneNameEn,
      this.zoneNameAr,
      this.delevieryFee,
      this.delevieryTimeInDays,
      this.createdAt,
      this.updatedAt,
      this.iV});

  DeliveryZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    zoneNameEn = json['zoneName_en'];
    zoneNameAr = json['zoneName_ar'];
    delevieryFee = json['delevieryFee'];
    delevieryTimeInDays = json['delevieryTimeInDays'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
