import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itime_frontend/models/loginResultResponse.dart';

import '../logger.dart';
import '../model/canteen.dart';
import '../utils/date_utils.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

class UserApi extends BaseApi {
  static final UserApi _instance = UserApi._();

  UserApi._()
      : super(
          baseUrl: 'http://116.63.196.15:8001/v1/user',
          cacheDbName: 'login_cache',
          defaultMaxAge: Duration(days: 1),
          defaultMaxStale: Duration(days: 7),
        );

  factory UserApi() {
    return _instance;
  }

  Future<LoginResultResponse?> login({
    required String studentId,
    required String pwd,
  }) async {
    final url = '/login?studentId=$studentId&pwd=$pwd';
    try {
      final response = await dio.post(url);
      final json = await parseJsonInBackground(utf8.decode(response.data));
      print(json);
      return LoginResultResponse.fromJson(json);
    } on Exception catch (_) {
      logger.e('Error getting LoginResultResponse from UserApi.\n$url');
      throw Exception('Error getting LoginResultResponse from UserApi.\n$url');
    }
  }
}
