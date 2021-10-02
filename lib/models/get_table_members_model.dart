import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'table_member_model.dart';

@immutable
class GetTableMembersModel {

  const GetTableMembersModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final List<TableMemberModel> data;

  factory GetTableMembersModel.fromJson(Map<String,dynamic> json) => GetTableMembersModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: (json['data'] as List? ?? []).map((e) => TableMemberModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data.map((e) => e.toJson()).toList()
  };

  GetTableMembersModel clone() => GetTableMembersModel(
    code: code,
    msg: msg,
    data: data.map((e) => e.clone()).toList()
  );


  GetTableMembersModel copyWith({
    int? code,
    String? msg,
    List<TableMemberModel>? data
  }) => GetTableMembersModel(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GetTableMembersModel && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}
