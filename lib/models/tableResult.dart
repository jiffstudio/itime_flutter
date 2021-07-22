import 'package:flutter/foundation.dart';
import 'eventsResult.dart';
import 'permissionResult.dart';

@immutable
class TableResult {

  const TableResult({
    required this.tableName,
    required this.type,
    required this.tableId,
    required this.events,
    required this.permission,
    required this.ownerId,
  });

  final String tableName;
  final String type;
  final String tableId;
  final List<EventsResult> events;
  final List<PermissionResult> permission;
  final String ownerId;

  factory TableResult.fromJson(Map<String,dynamic> json) => TableResult(
    tableName: json['tableName'] as String,
    type: json['type'] as String,
    tableId: json['tableId'] as String,
    events: (json['events'] as List? ?? []).map((e) =>  EventsResult.fromJson(e)).toList(),
    permission: (json['permission'] as List? ?? []).map((e) => PermissionResult.fromJson(e)).toList(),
    ownerId: json['ownerId'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'tableName': tableName,
    'type': type,
    'tableId': tableId,
    'events': events.map((e) => e.toString()).toList(),
    'permission': permission.map((e) => e.toString()).toList(),
    'ownerId': ownerId
  };

  TableResult clone() => TableResult(
    tableName: tableName,
    type: type,
    tableId: tableId,
    events: events.toList(),
    permission: permission.toList(),
    ownerId: ownerId
  );


  TableResult copyWith({
    String? tableName,
    String? type,
    String? tableId,
    List<EventsResult>? events,
    List<PermissionResult>? permission,
    String? ownerId
  }) => TableResult(
    tableName: tableName ?? this.tableName,
    type: type ?? this.type,
    tableId: tableId ?? this.tableId,
    events: events ?? this.events,
    permission: permission ?? this.permission,
    ownerId: ownerId ?? this.ownerId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TableResult && tableName == other.tableName && type == other.type && tableId == other.tableId && events == other.events && permission == other.permission && ownerId == other.ownerId;

  @override
  int get hashCode => tableName.hashCode ^ type.hashCode ^ tableId.hashCode ^ events.hashCode ^ permission.hashCode ^ ownerId.hashCode;
}
