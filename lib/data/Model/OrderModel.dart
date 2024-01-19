class OrderModel {
  var coupon;
  Address? address;
  String? status;
  String? sId;
  String? user;
  String? delevieryZoneId;
  String? zoneEn;
  String? zoneAr;
  String? addressId;
  int? totalItemsPrice;
  int? delevieryPrice;
  int? delevieryTimeInDays;
  String? paymentMethod;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;
  int? totalPrice;
  int? iV;

  OrderModel(
      {this.coupon,
      this.address,
      this.status,
      this.sId,
      this.user,
      this.delevieryZoneId,
      this.zoneEn,
      this.zoneAr,
      this.addressId,
      this.totalItemsPrice,
      this.delevieryPrice,
      this.delevieryTimeInDays,
      this.paymentMethod,
      this.items,
      this.createdAt,
      this.updatedAt,
      this.totalPrice,
      this.iV});

  OrderModel.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    status = json['status'];
    sId = json['_id'];
    user = json['user'];
    delevieryZoneId = json['delevieryZoneId'];
    zoneEn = json['zoneEn'];
    zoneAr = json['zoneAr'];
    addressId = json['addressId'];

    totalItemsPrice = json['totalItemsPrice'];
    delevieryPrice = json['delevieryPrice'];
    delevieryTimeInDays = json['delevieryTimeInDays'];
    paymentMethod = json['paymentMethod'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalPrice = json['totalPrice'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['coupon'] = this.coupon;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['status'] = status;
    data['_id'] = sId;
    data['user'] = user;
    data['delevieryZoneId'] = delevieryZoneId;
    data['zoneEn'] = zoneEn;
    data['zoneAr'] = zoneAr;
    data['addressId'] = addressId;
    data['totalItemsPrice'] = totalItemsPrice;
    data['delevieryPrice'] = delevieryPrice;
    data['delevieryTimeInDays'] = delevieryTimeInDays;
    data['paymentMethod'] = paymentMethod;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['totalPrice'] = totalPrice;
    data['__v'] = iV;
    return data;
  }
}

class Address {
  String? type;
  List<double>? coordinates;
  String? name;
  String? city;
  String? street;
  int? buildingNumber;
  int? floorNumber;
  int? apartmentNumber;

  Address({
    this.type,
    this.coordinates,
    this.name,
    this.city,
    this.street,
    this.buildingNumber,
    this.floorNumber,
    this.apartmentNumber,
  });

  Address.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    name = json['name'];
    city = json['city'];
    street = json['street'];
    buildingNumber = json['buildingNumber'];
    floorNumber = json['floorNumber'];
    apartmentNumber = json['apartmentNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    data['name'] = name;
    data['city'] = city;
    data['street'] = street;
    data['buildingNumber'] = buildingNumber;
    data['floorNumber'] = floorNumber;
    return data;
  }
}

class Items {
  SelectedVariation? selectedVariation;
  int? discount;
  String? sId;
  String? product;
  String? productName;
  String? productDesc;
  String? coverImage;
  int? quantity;
  int? price;

  Items(
      {this.selectedVariation,
      this.discount,
      this.sId,
      this.product,
      this.productName,
      this.productDesc,
      this.coverImage,
      this.quantity,
      this.price});

  Items.fromJson(Map<String, dynamic> json) {
    selectedVariation = json['selectedVariation'] != null
        ? SelectedVariation.fromJson(json['selectedVariation'])
        : null;
    discount = json['discount'];
    sId = json['_id'];
    productName = json['productName'];
    productDesc = json['productDescription'];
    coverImage = json['coverImage'];
    product = json['product'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (selectedVariation != null) {
      data['selectedVariation'] = selectedVariation!.toJson();
    }
    data['discount'] = discount;
    data['_id'] = sId;
    data['product'] = product;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class SelectedVariation {
  String? variationId;
  String? color;
  String? size;

  SelectedVariation({this.variationId, this.color, this.size});

  SelectedVariation.fromJson(Map<String, dynamic> json) {
    variationId = json['variationId'];
    color = json['color'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variationId'] = variationId;
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}
