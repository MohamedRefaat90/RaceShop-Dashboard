class userModel {
  String? role;
  bool? emailConfirmed;
  String? Id;
  String? name;
  String? email;
  int? V;
  String? passwordChangedAt;
  List<AddressModel>? address;
  String? gender;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  userModel(
      {this.role,
      this.emailConfirmed,
      this.Id,
      this.name,
      this.email,
      this.V,
      this.passwordChangedAt,
      this.address,
      this.gender,
      this.firstName,
      this.lastName,
      this.phoneNumber});

  userModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    emailConfirmed = json['emailConfirmed'];
    Id = json['_id'];
    name = json['name'];
    email = json['email'];
    V = json['__v'];
    passwordChangedAt = json['passwordChangedAt'];
    if (json['address'] != null) {
      address = <AddressModel>[];
      json['address'].forEach((v) {
        address!.add(new AddressModel.fromJson(v));
      });
    }
    gender = json['gender'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['emailConfirmed'] = this.emailConfirmed;
    data['_id'] = this.Id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['__v'] = this.V;
    data['passwordChangedAt'] = this.passwordChangedAt;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['gender'] = this.gender;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class AddressModel {
  String? type;
  List<double>? coordinates;
  String? name;
  String? Id;
  String? city;
  String? street;
  int? buildingNumber;
  int? floorNumber;
  int? apartmentNumber;

  AddressModel(
      {this.type,
      this.coordinates,
      this.name,
      this.Id,
      this.city,
      this.street,
      this.buildingNumber,
      this.floorNumber,
      this.apartmentNumber});

  AddressModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    name = json['name'];
    Id = json['_id'];
    city = json['city'];
    street = json['street'];
    buildingNumber = json['buildingNumber'];
    floorNumber = json['floorNumber'];
    apartmentNumber = json['apartmentNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['name'] = this.name;
    data['_id'] = this.Id;
    data['city'] = this.city;
    data['street'] = this.street;
    data['buildingNumber'] = this.buildingNumber;
    data['floorNumber'] = this.floorNumber;
    data['apartmentNumber'] = this.apartmentNumber;
    return data;
  }
}
