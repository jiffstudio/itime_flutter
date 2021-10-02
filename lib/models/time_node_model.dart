import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class TimeNodeModel {

  const TimeNodeModel({
    required this.termId,
    required this.startDate,
    required this.weekNum,
  });

  final String termId;
  final DateTime startDate;
  final int weekNum;

  factory TimeNodeModel.fromJson(Map<String,dynamic> json) => TimeNodeModel(
    termId: json['termId'] as String,
    startDate: DateTime.parse(json['startDate'] as String),
    weekNum: json['weekNum'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'termId': termId,
    'startDate': startDate.toIso8601String(),
    'weekNum': weekNum
  };

  TimeNodeModel clone() => TimeNodeModel(
    termId: termId,
    startDate: startDate,
    weekNum: weekNum
  );


  TimeNodeModel copyWith({
    String? termId,
    DateTime? startDate,
    int? weekNum
  }) => TimeNodeModel(
    termId: termId ?? this.termId,
    startDate: startDate ?? this.startDate,
    weekNum: weekNum ?? this.weekNum,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TimeNodeModel && termId == other.termId && startDate == other.startDate && weekNum == other.weekNum;

  @override
  int get hashCode => termId.hashCode ^ startDate.hashCode ^ weekNum.hashCode;
}
