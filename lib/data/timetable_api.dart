import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itime_frontend/models/get_all_tables_model.dart';
import 'package:itime_frontend/models/get_table_members_model.dart';
import 'package:itime_frontend/models/login_model.dart';
import 'package:itime_frontend/models/create_table_model.dart';
import '../logger.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

class TimetableApi extends BaseApi {
  static final TimetableApi _instance = TimetableApi._();

  TimetableApi._()
      : super();

  factory TimetableApi() {
    return _instance;
  }

  Future<LoginModel> getTimetable({
    required String tableId,
    required String term,
    required String pwd,
  }) async {
    final url = '/table?studentId=$tableId&pwd=$pwd';
    try {
      final response = await dio.post(url);
      final json = await parseJsonInBackground(utf8.decode(response.data));
      print(json);
      return LoginModel.fromJson(json);
    } on Exception catch (e) {
      logger.e('Error ${e.toString()}getting LoginResultResponse from TimetableApi.\n$url');
      throw Exception('Error getting LoginResultResponse from TimetableApi.\n$url\n$e');
    }
  }

  Future<GetAllTablesModel> getAllTimetables({
    required String termId,
    required String pwd,
  }) async {
    final url = '/table/all';
    try {
      final response = await dio.get(url, queryParameters: {
        "pwd": pwd,
        "termId": termId,
      });
      return GetAllTablesModel.fromJson(response.data);
    } on Exception catch (e) {
      logger.e('Error ${e.toString()}getting LoginResultResponse from TimetableApi.\n$url');
      throw Exception('Error getting LoginResultResponse from TimetableApi.\n$url\n$e');
    }
  }

  Future<CreateTableModel> createTimetable({
    required String tableName,
    required String tableType,
  }) async {
    final url = '/table';
    try {
      final response = await dio.post(url, data: {
        "tableName": tableName,
        "tableType": tableType,
      });
      return CreateTableModel.fromJson(response.data);
    } on Exception catch (e) {
      throw Exception('Error creating Timetable from TimetableApi.\n$url\n$e');
    }
  }

  Future<void> deleteTimetable({
    required String tableId,
  }) async {
    final url = '/table';
    try {
      final response = await dio.delete(url, data: {
        "tableId": tableId,
      });
    } on Exception catch (e) {
      throw Exception('Error deleting Timetable from TimetableApi.\n$url\n$e');
    }
  }
}
