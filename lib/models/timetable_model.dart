import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'event_model.dart';
import 'permission_model.dart';

@immutable
class TimetableModel {

  const TimetableModel({
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
  final List<EventModel> events;
  final List<PermissionModel> permission;
  final String ownerId;

  factory TimetableModel.fromJson(Map<String,dynamic> json) => TimetableModel(
    tableName: json['tableName'] as String,
    type: json['type'] as String,
    tableId: json['tableId'] as String,
    events: (json['events'] as List? ?? []).map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList(),
    permission: (json['permission'] as List? ?? []).map((e) => PermissionModel.fromJson(e as Map<String, dynamic>)).toList(),
    ownerId: json['ownerId'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'tableName': tableName,
    'type': type,
    'tableId': tableId,
    'events': events.map((e) => e.toJson()).toList(),
    'permission': permission.map((e) => e.toJson()).toList(),
    'ownerId': ownerId
  };

  TimetableModel clone() => TimetableModel(
    tableName: tableName,
    type: type,
    tableId: tableId,
    events: events.map((e) => e.clone()).toList(),
    permission: permission.map((e) => e.clone()).toList(),
    ownerId: ownerId
  );


  TimetableModel copyWith({
    String? tableName,
    String? type,
    String? tableId,
    List<EventModel>? events,
    List<PermissionModel>? permission,
    String? ownerId
  }) => TimetableModel(
    tableName: tableName ?? this.tableName,
    type: type ?? this.type,
    tableId: tableId ?? this.tableId,
    events: events ?? this.events,
    permission: permission ?? this.permission,
    ownerId: ownerId ?? this.ownerId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TimetableModel && tableName == other.tableName && type == other.type && tableId == other.tableId && events == other.events && permission == other.permission && ownerId == other.ownerId;

  @override
  int get hashCode => tableName.hashCode ^ type.hashCode ^ tableId.hashCode ^ events.hashCode ^ permission.hashCode ^ ownerId.hashCode;
}
