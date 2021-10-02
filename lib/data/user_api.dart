import 'dart:convert';

import '../logger.dart';
import '../models/login_model.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

class UserApi extends BaseApi {
  static final UserApi _instance = UserApi._();

  UserApi._() : super();

  factory UserApi() {
    return _instance;
  }

  Future<LoginModel> login({
    required String studentId,
    required String pwd,
  }) async {
    final url = '/user/login';
    try {
      final response = await dio.post(url, data: {
        "studentId": studentId,
        "pwd": pwd,
      });
      LoginModel loginModel = LoginModel.fromJson(response.data);
      dio.addAuthorization(
          jwt: loginModel.data.accessToken,
          refreshToken: loginModel.data.refreshToken);
      return loginModel;
    } on Exception catch (e) {
      logger.e(
          'Error getting LoginResultResponse from UserApi.\n${e.toString()}\n$url');
      throw Exception(
          'Error getting LoginResultResponse from UserApi.\n$url\n$e');
    }
  }
}
