import 'dart:convert';
import 'package:flutter_desired_job/constants/dj_const.dart';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:flutter_desired_job/models/business_model.dart';
import 'package:flutter_desired_job/models/email_model.dart';
import 'package:flutter_desired_job/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class ImpAuthServices {
  Future<List<AccountModel>?> getAccounts();
  Future<List<UserModel>?> getUsers();
  Future<List<BusinessModel>?> getBusiness();
  Future<http.Response> addAccount(AccountModel account);
  Future<http.Response> addUser(UserModel user);
  Future<http.Response> addBusiness(BusinessModel business);
  Future<http.Response> updateAccount(AccountModel account);
  Future<http.Response> updateBusiness(BusinessModel business);
  Future<http.Response> updateUser(UserModel user);
  Future<AccountModel?> getMyAccount(String id);
  Future<BusinessModel?> getMyBusiness(String id);
  // Future<UserModel?> getMyUser(String email);
  Future<http.Response> removeAccount(String id);
  Future<http.Response> removeUser(String id);
  Future<http.Response> removeBusiness(String id);
  Future<http.Response> sendOtp(EmailModel emailModel);
  Future<String?> uploadAvatar(String? filePath);
}

class AuthServices implements ImpAuthServices {
  @override
  Future<List<AccountModel>?> getAccounts() async {
    const url = DJConst.endPointAccounts;

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) return [];
        List<AccountModel> users =
            data.map((e) => AccountModel.fromJson(e)).toList();

        return users;
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      throw Exception();
    }
  }

  @override
  Future<List<UserModel>?> getUsers() async {
    const url = DJConst.endPointUsers;

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isEmpty) return [];
        List<UserModel> users = data.map((e) => UserModel.fromJson(e)).toList();

        return users;
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      throw Exception();
    }
  }

    @override
  Future<List<BusinessModel>?> getBusiness() async {
    const url = DJConst.endPointBusiness;

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isEmpty) return [];
        List<BusinessModel> business = data.map((e) => BusinessModel.fromJson(e)).toList();

        return business;
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      throw Exception();
    }
  }

  @override
  Future<http.Response> addAccount(AccountModel account) async {
    const url = DJConst.endPointAccounts;
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(account.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> addUser(UserModel user) async {
    const url = DJConst.endPointUsers;
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> addBusiness(BusinessModel business) async {
    const url = DJConst.endPointBusiness;
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(business.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> updateAccount(AccountModel account) async {
    final url = '${DJConst.endPointAccounts}?id=eq.${account.id}';

    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(account.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> updateUser(UserModel user) async {
    final url = '${DJConst.endPointUsers}?accountId=eq.${user.accountId}';

    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    return response;
  }

  @override
  Future<http.Response> updateBusiness(BusinessModel business) async {
    final url =
        '${DJConst.endPointBusiness}?accountId=eq.${business.accountId}';
    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(business.toJson()),
    );

    return response;
  }

  @override
  Future<AccountModel?> getMyAccount(String email) async {
    final url = DJConst.endPointMyAccount(email);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) return null;
        return AccountModel.fromJson(data[0] as Map<String, dynamic>);
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      rethrow;
    }
  }

  @override
  Future<BusinessModel?> getMyBusiness(String id) async {
    final url = DJConst.endPointMyBusiness(id);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'apikey': DJConst.apiKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) return null;
        // final job = JobModel.fromJson(data[0]['myJobs'][0]);
        // print('object 11 $job');
        return BusinessModel.fromJson(data[0] as Map<String, dynamic>);
      } else {
        throw Exception();
      }
    } on http.ClientException catch (_) {
      rethrow;
    }
  }

  // @override
  // Future<UserModel?> getMyUser(String email) async {
  //   final url = DJConst.endPointMyUser(email);
  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'apikey': DJConst.apiKey,
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       final data = jsonDecode(response.body);
  //       return UserModel.fromJson(data[0] as Map<String, dynamic>);
  //     } else {
  //       throw Exception();
  //     }
  //   } on http.ClientException catch (_) {
  //     rethrow;
  //   }
  // }

  @override
  Future<http.Response> removeAccount(String id) async {
    final url = DJConst.endPointRemoveAccount(id);

    final response = http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Future<http.Response> removeUser(String id) async {
    final url = DJConst.endPointRemoveUser(id);

    final response = http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Future<http.Response> removeBusiness(String id) async {
    final url = DJConst.endPointRemoveBusiness(id);

    final response = http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'apikey': DJConst.apiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Future<http.Response> sendOtp(EmailModel emailModel) async {
    final uri = Uri.parse(DJConst.baseUploadSendEmail);

    final response = await http.post(
      uri,
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'service_id': DJConst.servicesId,
        'user_id': DJConst.userId,
        'template_id': DJConst.templateId,
        'template_params': emailModel.toJson(),
      }),
    );

    return response;
  }

  @override
  Future<String?> uploadAvatar(String? filePath) async {
    final uri = Uri.parse(DJConst.baseUploadImage);

    if (filePath == null) return null;
    try {
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'j7dm7shb'
        ..files.add(await http.MultipartFile.fromPath('file', filePath));
      final response = await request.send();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonBody = jsonDecode(responseString);
        return jsonBody['url'];
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
