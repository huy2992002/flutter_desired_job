import 'package:flutter_desired_job/models/user_model.dart';

class CVModel {
  String? id;
  UserModel? user;
  String? introduce;
  String? education;
  String? strengths;

  CVModel();

  factory CVModel.fromJson(Map<String, dynamic> json) {
    return CVModel()
      ..id = json['id'] as String?
      ..user = json['user'] != null
          ? UserModel.fromJson(
              json['user'],
            )
          : null
      ..introduce = json['introduce']
      ..education = json['education']
      ..strengths = json['strengths'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJsonApply(),
      'introduce': introduce,
      'education': education,
      'strengths': strengths,
    };
  }
}
