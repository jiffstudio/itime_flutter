import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class CreateTableModel {

  const CreateTableModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final Data data;

  factory CreateTableModel.fromJson(Map<String,dynamic> json) => CreateTableModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data.toJson()
  };

  CreateTableModel clone() => CreateTableModel(
    code: code,
    msg: msg,
    data: data.clone()
  );


  CreateTableModel copyWith({
    int? code,
    String? msg,
    Data? data
  }) => CreateTableModel(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is CreateTableModel && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}

@immutable
class Data {

  const Data({
    required this.tableId,
  });

  final String tableId;

  factory Data.fromJson(Map<String,dynamic> json) => Data(
    tableId: json['tableId'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'tableId': tableId
  };

  Data clone() => Data(
    tableId: tableId
  );


  Data copyWith({
    String? tableId
  }) => Data(
    tableId: tableId ?? this.tableId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Data && tableId == other.tableId;

  @override
  int get hashCode => tableId.hashCode;
}
