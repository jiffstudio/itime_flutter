import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itime_frontend/models/get_all_tables_model.dart';
import 'package:itime_frontend/models/get_table_members_model.dart';
import 'package:itime_frontend/models/get_table_share_model.dart';
import 'package:itime_frontend/models/login_model.dart';
import 'package:itime_frontend/models/create_table_model.dart';
import '../logger.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

class ShareApi extends BaseApi {
  static final ShareApi _instance = ShareApi._();

  ShareApi._()
      : super();

  factory ShareApi() {
    return _instance;
  }

  Future<GetTableMembersModel> getTimetableMembers({
    required String tableId,
  }) async {
    final url = '/syllabus/share/permission';
    try {
      final response = await dio.get(url, queryParameters: {
        "tableId": tableId,
      });
      return GetTableMembersModel.fromJson(response.data);
    } on Exception catch (e) {
      logger.e('Error ${e.toString()}getting TableMembers from ShareApi.\n$url');
      throw Exception('Error getting TableMembers from ShareApi.\n$url\n$e');
    }
  }

  Future<GetTableShareModel> getTimetableShare({
    required String tableId,
    required bool readOnly,
  }) async {
    final url = '/syllabus/share';
    try {
      final response = await dio.post(url, data: {
        "tableId": tableId,
        "readOnly": readOnly,
      });
      return GetTableShareModel.fromJson(response.data);
    } on Exception catch (e) {
      logger.e('Error ${e.toString()}getting ShareId from ShareApi.\n$url');
      throw Exception('Error getting ShareId from ShareApi.\n$url\n$e');
    }
  }
}
