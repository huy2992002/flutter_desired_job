class BusinessModel {
  String? id;
  String? name;
  String? avatar;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  AddressModel? address;
  String? website;
  String? career;
  int? size;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? accountId;

  BusinessModel({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.address,
    this.website,
    this.career,
    this.size,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (email != null) 'email': email,
      if (emailVerifiedAt != null) 'emailVerifiedAt': emailVerifiedAt,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      if (website != null) 'website': website,
      if (career != null) 'career': career,
      if (size != null) 'size': size,
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (deletedAt != null) 'deletedAt': deletedAt,
      if (accountId != null) 'accountId': accountId,
    };
  }

  Map<String, dynamic> toJsonJob() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (email != null) 'email': email,
      if (emailVerifiedAt != null) 'emailVerifiedAt': emailVerifiedAt,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      if (website != null) 'website': website,
      if (career != null) 'career': career,
      if (size != null) 'size': size,
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (deletedAt != null) 'deletedAt': deletedAt,
      if (accountId != null) 'accountId': accountId,
    };
  }

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      website: json['website'] as String?,
      career: json['career'] as String?,
      size: json['size'] as int?,
      status: json['status'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      accountId: json['accountId'] as String?,
    );
  }
}

class AddressModel {
  String? location;
  double? lat;
  double? long;

  AddressModel();

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel()
      ..location = json['location'] as String?
      ..lat = json['lat'] as double?
      ..long = json['long'] as double?;
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'lat': lat,
      'long': long,
    };
  }
}
