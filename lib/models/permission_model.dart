import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class PermissionModel {

  const PermissionModel({
    required this.userId,
    required this.tableId,
    required this.read,
    required this.edit,
    required this.insert,
    required this.delete,
  });

  final String userId;
  final String tableId;
  final bool read;
  final bool edit;
  final bool insert;
  final bool delete;

  factory PermissionModel.fromJson(Map<String,dynamic> json) => PermissionModel(
    userId: json['userId'] as String,
    tableId: json['tableId'] as String,
    read: json['read'] as bool,
    edit: json['edit'] as bool,
    insert: json['insert'] as bool,
    delete: json['delete'] as bool
  );
  
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'tableId': tableId,
    'read': read,
    'edit': edit,
    'insert': insert,
    'delete': delete
  };

  PermissionModel clone() => PermissionModel(
    userId: userId,
    tableId: tableId,
    read: read,
    edit: edit,
    insert: insert,
    delete: delete
  );


  PermissionModel copyWith({
    String? userId,
    String? tableId,
    bool? read,
    bool? edit,
    bool? insert,
    bool? delete
  }) => PermissionModel(
    userId: userId ?? this.userId,
    tableId: tableId ?? this.tableId,
    read: read ?? this.read,
    edit: edit ?? this.edit,
    insert: insert ?? this.insert,
    delete: delete ?? this.delete,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PermissionModel && userId == other.userId && tableId == other.tableId && read == other.read && edit == other.edit && insert == other.insert && delete == other.delete;

  @override
  int get hashCode => userId.hashCode ^ tableId.hashCode ^ read.hashCode ^ edit.hashCode ^ insert.hashCode ^ delete.hashCode;
}
