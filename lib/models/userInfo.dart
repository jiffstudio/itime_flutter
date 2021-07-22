import 'package:flutter/foundation.dart';


@immutable
class UserInfo {

  const UserInfo({
    required this.name,
    required this.grade,
    required this.classId,
    required this.major,
  });

  final String name;
  final String grade;
  final String classId;
  final String major;

  factory UserInfo.fromJson(Map<String,dynamic> json) => UserInfo(
    name: json['name'] as String,
    grade: json['grade'] as String,
    classId: json['classId'] as String,
    major: json['major'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'grade': grade,
    'classId': classId,
    'major': major
  };

  UserInfo clone() => UserInfo(
    name: name,
    grade: grade,
    classId: classId,
    major: major
  );


  UserInfo copyWith({
    String? name,
    String? grade,
    String? classId,
    String? major
  }) => UserInfo(
    name: name ?? this.name,
    grade: grade ?? this.grade,
    classId: classId ?? this.classId,
    major: major ?? this.major,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UserInfo && name == other.name && grade == other.grade && classId == other.classId && major == other.major;

  @override
  int get hashCode => name.hashCode ^ grade.hashCode ^ classId.hashCode ^ major.hashCode;
}
