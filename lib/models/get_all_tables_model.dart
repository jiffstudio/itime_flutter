import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'timetable_model.dart';

@immutable
class GetAllTablesModel {

  const GetAllTablesModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final List<TimetableModel> data;

  factory GetAllTablesModel.fromJson(Map<String,dynamic> json) => GetAllTablesModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: (json['data'] as List? ?? []).map((e) => TimetableModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data.map((e) => e.toJson()).toList()
  };

  GetAllTablesModel clone() => GetAllTablesModel(
    code: code,
    msg: msg,
    data: data.map((e) => e.clone()).toList()
  );


  GetAllTablesModel copyWith({
    int? code,
    String? msg,
    List<TimetableModel>? data
  }) => GetAllTablesModel(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GetAllTablesModel && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}
