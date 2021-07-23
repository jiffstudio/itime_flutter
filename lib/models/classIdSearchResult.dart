import 'package:flutter/foundation.dart';
import 'classEventResult.dart';
import 'classPermission.dart';

@immutable
class ClassIdSearchResult {

  const ClassIdSearchResult({
    required this.tableName,
    required this.type,
    required this.tableId,
    required this.events,
    required this.permission,
    required this.classId,
  });

  final String tableName;
  final String type;
  final String tableId;
  final List<ClassEventResult> events;
  final List<ClassPermission> permission;
  final String classId;

  factory ClassIdSearchResult.fromJson(Map<String,dynamic> json) => ClassIdSearchResult(
    tableName: json['tableName'] as String,
    type: json['type'] as String,
    tableId: json['tableId'] as String,
    events: (json['events'] as List? ?? []).map((e) => ClassEventResult.fromJson(e)).toList(),
    permission: (json['permission'] as List? ?? []).map((e) => ClassPermission.fromJson(e)).toList(),
    classId: json['classId'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'tableName': tableName,
    'type': type,
    'tableId': tableId,
    'events': events.map((e) => e.toString()).toList(),
    'permission': permission.map((e) => e.toString()).toList(),
    'classId': classId
  };

  ClassIdSearchResult clone() => ClassIdSearchResult(
    tableName: tableName,
    type: type,
    tableId: tableId,
    events: events.toList(),
    permission: permission.toList(),
    classId: classId
  );


  ClassIdSearchResult copyWith({
    String? tableName,
    String? type,
    String? tableId,
    List<ClassEventResult>? events,
    List<ClassPermission>? permission,
    String? classId
  }) => ClassIdSearchResult(
    tableName: tableName ?? this.tableName,
    type: type ?? this.type,
    tableId: tableId ?? this.tableId,
    events: events ?? this.events,
    permission: permission ?? this.permission,
    classId: classId ?? this.classId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ClassIdSearchResult && tableName == other.tableName && type == other.type && tableId == other.tableId && events == other.events && permission == other.permission && classId == other.classId;

  @override
  int get hashCode => tableName.hashCode ^ type.hashCode ^ tableId.hashCode ^ events.hashCode ^ permission.hashCode ^ classId.hashCode;
}
