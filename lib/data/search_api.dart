import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itime_frontend/models/loginResultResponse.dart';

import '../logger.dart';
import '../model/canteen.dart';
import '../utils/date_utils.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

class SearchApi extends BaseApi {
  static final SearchApi _instance = SearchApi._();

  SearchApi._()
      : super(
          baseUrl: 'http://116.63.196.15:8001/v1/search',
          cacheDbName: 'search_cache',
          defaultMaxAge: Duration(days: 1),
          defaultMaxStale: Duration(days: 7),
        );

  factory SearchApi() {
    return _instance;
  }

  Future<LoginResultResponse?> login({
    required String accessToken,
    required String feature,
    required int courseNameSearchLimit,
    required int teacherNameSearchLimit,
    required int locationSearchLimit,
    required int classIdSearchLimit,
  }) async {
    final url = '/?accessToken=$accessToken&feature=$feature&courseNameSearchLimit=$courseNameSearchLimit&teacherNameSearchLimit=$teacherNameSearchLimit&locationSearchLimit=$locationSearchLimit&classIdSearchLimit=$classIdSearchLimit';
    try {
      final response = await dio.get(url);
      final json = await parseJsonInBackground(utf8.decode(response.data));
      print(json);
      return LoginResultResponse.fromJson(json);
    } on Exception catch (_) {
      logger.e('Error getting CanteenWeek from EatApi.\n$url');
      return null;
    }
  }
}
