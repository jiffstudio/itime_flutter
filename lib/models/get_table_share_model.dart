import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class GetTableShareModel {

  const GetTableShareModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final Data data;

  factory GetTableShareModel.fromJson(Map<String,dynamic> json) => GetTableShareModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data.toJson()
  };

  GetTableShareModel clone() => GetTableShareModel(
    code: code,
    msg: msg,
    data: data.clone()
  );


  GetTableShareModel copyWith({
    int? code,
    String? msg,
    Data? data
  }) => GetTableShareModel(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GetTableShareModel && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}

@immutable
class Data {

  const Data({
    required this.shareId,
  });

  final String shareId;

  factory Data.fromJson(Map<String,dynamic> json) => Data(
    shareId: json['shareId'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'shareId': shareId
  };

  Data clone() => Data(
    shareId: shareId
  );


  Data copyWith({
    String? shareId
  }) => Data(
    shareId: shareId ?? this.shareId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Data && shareId == other.shareId;

  @override
  int get hashCode => shareId.hashCode;
}
