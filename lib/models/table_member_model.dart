import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class TableMemberModel {

  const TableMemberModel({
    required this.userId,
    required this.userName,
    required this.tableId,
    required this.readOnly,
  });

  final String userId;
  final String userName;
  final String tableId;
  final bool readOnly;

  factory TableMemberModel.fromJson(Map<String,dynamic> json) => TableMemberModel(
    userId: json['userId'] as String,
    userName: json['userName'] as String,
    tableId: json['tableId'] as String,
    readOnly: json['readOnly'] as bool
  );
  
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'tableId': tableId,
    'readOnly': readOnly
  };

  TableMemberModel clone() => TableMemberModel(
    userId: userId,
    userName: userName,
    tableId: tableId,
    readOnly: readOnly
  );


  TableMemberModel copyWith({
    String? userId,
    String? userName,
    String? tableId,
    bool? readOnly
  }) => TableMemberModel(
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    tableId: tableId ?? this.tableId,
    readOnly: readOnly ?? this.readOnly,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TableMemberModel && userId == other.userId && userName == other.userName && tableId == other.tableId && readOnly == other.readOnly;

  @override
  int get hashCode => userId.hashCode ^ userName.hashCode ^ tableId.hashCode ^ readOnly.hashCode;
}
