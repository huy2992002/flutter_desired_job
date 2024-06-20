import 'dart:convert';

import 'package:flutter_desired_job/constants/dj_const.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:http/http.dart' as http;

abstract class ImpJobServices {
  Future<List<JobModel>?> getJobs();
  Future<http.Response> addJobs(JobModel job);
  Future<http.Response> updateJob(JobModel job);
  Future<http.Response> removeJob(String id);
  Future<http.Response> removeJobBusinessId(String businessId);
  Future<List<JobModel>?> getFavoriteJobs(String id);
  Future<List<JobModel>?> getBusinessJobs(String businessId);
  Future<void> updateFavoriteJobs(String email, List<JobModel> favoriteJobs);
}

class JobService implements ImpJobServices {
  @override
  Future<List<JobModel>?> getJobs() async {
    const url = DJConst.endPointJob;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        List<JobModel> users = data.map((e) => JobModel.fromJson(e)).toList();
        return users;
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      throw Exception();
    }
  }

  @override
  Future<http.Response> addJobs(JobModel job) async {
    const url = DJConst.endPointJob;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
        'Prefer': 'return=minimal',
      },
      body: jsonEncode(job.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> updateJob(JobModel job) async {
    final url = '${DJConst.endPointJob}?id=eq.${job.id}';

    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(job.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> removeJob(String id) async {
    final url = '${DJConst.endPointJob}?id=eq.$id';

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Future<http.Response> removeJobBusinessId(String businessId) async {
    final url = '${DJConst.endPointJob}?businessId=eq.$businessId';

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Future<List<JobModel>?> getFavoriteJobs(String id) async {
    final url = DJConst.endPointFavoriteJob(id);

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isEmpty) return null;
        List<dynamic>? results = data[0]['favoriteJobs'];
        return results
            ?.map((e) => JobModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<JobModel>?> getBusinessJobs(String businessId) async {
    final url = DJConst.endPointBusinessJobs(businessId);

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isEmpty) return null;
        return data
            .map((e) => JobModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateFavoriteJobs(
      String id, List<JobModel> favoriteJobs) async {
    final url = DJConst.endPointUpdateFavoriteJob(id);
    List<Map<String, dynamic>> maps =
        favoriteJobs.map((e) => e.toJson()).toList();
    try {
      await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'favoriteJobs': maps,
          },
        ),
      );
    } catch (_) {
      rethrow;
    }
  }
}
