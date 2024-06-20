class AccountModel {
  String? id;
  String? name;
  String? numberPhone;
  String? email;
  String? password;
  String? avatar;
  int? role;
  bool? isBlock;

  AccountModel();

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel()
    ..id = json['id'] as String?
    ..name = json['name'] as String?
    ..numberPhone = json['numberPhone'] as String?
    ..email = json['email'] as String?
    ..password = json['password'] as String?
    ..avatar = json['avatar'] as String?
    ..role = json['role'] as int?
    ..isBlock = json['isBlock'] as bool?;

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (numberPhone != null) 'numberPhone': numberPhone,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (avatar != null) 'avatar': avatar,
      if (role != null) 'role': role,
      if (isBlock != null) 'isBlock': isBlock,
    };
  }

  Map<String, dynamic> toJsonLocal() {
    return {
      'id': id,
      'name': name,
      'numberPhone': numberPhone,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }

  Map<String, dynamic> toJsonApply() {
    return {
      'id': id,
      'name': name,
      'numberPhone': numberPhone,
      'email': email,
      'avatar': avatar,
    };
  }
}
