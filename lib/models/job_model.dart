import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/cv_model.dart';

class JobModel {
  String? id;
  String? businessId;
  String? position;
  List<String>? levels;
  double? salary;
  String? content;
  List<String>? skills;
  List<String>? types;
  String? requirement;
  int? quantity;
  String? benefits;
  String? startDay;
  String? endDay;
  int? viewCount;
  String? createdAt;
  bool? isPopular;
  bool? isRecent;
  bool? isApproved;
  bool? isHidden;
  List<CVModel>? cvs;
  BusinessModel? business;

  JobModel({
    this.id,
    this.businessId,
    this.position,
    this.levels,
    this.salary,
    this.content,
    this.skills,
    this.types,
    this.requirement,
    this.quantity,
    this.benefits,
    this.startDay,
    this.endDay,
    this.viewCount,
    this.createdAt,
    this.isPopular,
    this.isRecent,
    this.isApproved,
    this.isHidden,
    this.cvs,
    this.business,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (businessId != null) 'businessId': businessId,
      if (position != null) 'position': position,
      if (levels != null) 'levels': levels,
      if (salary != null) 'salary': salary,
      if (content != null) 'content': content,
      if (skills != null) 'skills': skills,
      if (types != null) 'types': types,
      if (requirement != null) 'requirement': requirement,
      if (quantity != null) 'quantity': quantity,
      if (benefits != null) 'benefits': benefits,
      if (startDay != null) 'startDay': startDay,
      if (endDay != null) 'endDay': endDay,
      if (viewCount != null) 'viewCount': viewCount,
      if (createdAt != null) 'createdAt': createdAt,
      if (isPopular != null) 'isPopular': isPopular,
      if (isRecent != null) 'isRecent': isRecent,
      if (isApproved != null) 'isApproved': isApproved,
      if (isHidden != null) 'isHidden': isHidden,
      if (cvs != null) 'cvs': cvs,
      if (business != null) 'business': business?.toJsonJob(),
    };
  }

  JobStatus getJobStatus() {
    if (isHidden ?? false) return JobStatus.hidden;
    if (endDay == null || startDay == null) return JobStatus.expired;
    if ((isApproved ?? false) == false) {
      return JobStatus.censoring;
    } else if (DateTime.parse(startDay!).isAfter(DateTime.now())) {
      return JobStatus.almostOpen;
    } else if (DateTime.parse(endDay!).isBefore(DateTime.now())) {
      return JobStatus.expired;
    } else {
      return JobStatus.open;
    }
  }

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String?,
      businessId: json['businessId'] as String?,
      position: json['position'] as String?,
      levels:
          (json['levels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      salary: json['salary'] != null
          ? double.parse(json['salary'].toString())
          : null,
      content: json['content'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      requirement: json['requirement'] as String?,
      quantity: json['quantity'] as int?,
      benefits: json['benefits'] as String?,
      startDay: json['startDay'] as String?,
      endDay: json['endDay'] as String?,
      viewCount: json['viewCount'] as int?,
      createdAt: json['createdAt'] as String?,
      isPopular: json['isPopular'] as bool?,
      isRecent: json['isRecent'] as bool?,
      isApproved: json['isApproved'] as bool?,
      isHidden: json['isHidden'] as bool?,
      cvs: (json['cvs'] as List<dynamic>?)
          ?.map((e) => CVModel.fromJson(e))
          .toList(),
      business: json['business'] == null
          ? null
          : BusinessModel.fromJson(json['business'] as Map<String, dynamic>),
    );
  }
}

enum JobStatus {
  open,
  censoring,
  expired,
  almostOpen,
  hidden,
}
