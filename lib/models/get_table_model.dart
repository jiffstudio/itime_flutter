import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'event_model.dart';

@immutable
class GetTableModel {

  const GetTableModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final Data data;

  factory GetTableModel.fromJson(Map<String,dynamic> json) => GetTableModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data.toJson()
  };

  GetTableModel clone() => GetTableModel(
    code: code,
    msg: msg,
    data: data.clone()
  );


  GetTableModel copyWith({
    int? code,
    String? msg,
    Data? data
  }) => GetTableModel(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GetTableModel && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}

@immutable
class Data {

  const Data({
    this.tableName,
    required this.events,
  });

  final String? tableName;
  final List<EventModel> events;

  factory Data.fromJson(Map<String,dynamic> json) => Data(
    tableName: json['tableName'] != null ? json['tableName'] as String : null,
    events: (json['events'] as List? ?? []).map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'tableName': tableName,
    'events': events.map((e) => e.toJson()).toList()
  };

  Data clone() => Data(
    tableName: tableName,
    events: events.map((e) => e.clone()).toList()
  );


  Data copyWith({
    Optional<String?>? tableName,
    List<EventModel>? events
  }) => Data(
    tableName: checkOptional(tableName, this.tableName),
    events: events ?? this.events,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Data && tableName == other.tableName && events == other.events;

  @override
  int get hashCode => tableName.hashCode ^ events.hashCode;
}
