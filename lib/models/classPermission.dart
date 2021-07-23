import 'package:flutter/foundation.dart';


@immutable
class ClassPermission {

  const ClassPermission({
    required this.userId,
    required this.userName,
    required this.tableId,
    required this.read,
    required this.edit,
    required this.insert,
    required this.delete,
  });

  final String userId;
  final String userName;
  final String tableId;
  final bool read;
  final bool edit;
  final bool insert;
  final bool delete;

  factory ClassPermission.fromJson(Map<String,dynamic> json) => ClassPermission(
    userId: json['userId'] as String,
    userName: json['userName'] as String,
    tableId: json['tableId'] as String,
    read: json['read'] as bool,
    edit: json['edit'] as bool,
    insert: json['insert'] as bool,
    delete: json['delete'] as bool
  );
  
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'tableId': tableId,
    'read': read,
    'edit': edit,
    'insert': insert,
    'delete': delete
  };

  ClassPermission clone() => ClassPermission(
    userId: userId,
    userName: userName,
    tableId: tableId,
    read: read,
    edit: edit,
    insert: insert,
    delete: delete
  );


  ClassPermission copyWith({
    String? userId,
    String? userName,
    String? tableId,
    bool? read,
    bool? edit,
    bool? insert,
    bool? delete
  }) => ClassPermission(
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    tableId: tableId ?? this.tableId,
    read: read ?? this.read,
    edit: edit ?? this.edit,
    insert: insert ?? this.insert,
    delete: delete ?? this.delete,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ClassPermission && userId == other.userId && userName == other.userName && tableId == other.tableId && read == other.read && edit == other.edit && insert == other.insert && delete == other.delete;

  @override
  int get hashCode => userId.hashCode ^ userName.hashCode ^ tableId.hashCode ^ read.hashCode ^ edit.hashCode ^ insert.hashCode ^ delete.hashCode;
}
