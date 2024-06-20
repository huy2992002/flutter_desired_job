class UserModel {
  String? id;
  String? name;
  String? numberPhone;
  String? email;
  String? avatar;
  String? accountId;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel()
    ..id = json['id'] as String?
    ..name = json['name'] as String?
    ..numberPhone = json['numberPhone'] as String?
    ..email = json['email'] as String?
    ..avatar = json['avatar'] as String?
    ..accountId = json['accountId'] as String?;

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (numberPhone != null) 'numberPhone': numberPhone,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (accountId != null) 'accountId': accountId,
    };
  }

  Map<String, dynamic> toJsonApply() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (numberPhone != null) 'numberPhone': numberPhone,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
    };
  }
}
