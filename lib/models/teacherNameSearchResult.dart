import 'package:flutter/foundation.dart';
import 'teacherTimeResult.dart';

@immutable
class TeacherNameSearchResult {

  const TeacherNameSearchResult({
    required this.eventId,
    required this.name,
    required this.location,
    required this.tableId,
    required this.colorId,
    required this.time,
    required this.eventType,
    required this.compulsory,
    required this.teacher,
    required this.courseCode,
    required this.courseNo,
  });

  final int eventId;
  final String name;
  final String location;
  final String tableId;
  final int colorId;
  final List<TeacherTimeResult> time;
  final String eventType;
  final String compulsory;
  final String teacher;
  final String courseCode;
  final String courseNo;

  factory TeacherNameSearchResult.fromJson(Map<String,dynamic> json) => TeacherNameSearchResult(
    eventId: json['eventId'] as int,
    name: json['name'] as String,
    location: json['location'] as String,
    tableId: json['tableId'] as String,
    colorId: json['colorId'] as int,
    time: (json['time'] as List? ?? []).map((e) => TeacherTimeResult.fromJson(e)).toList(),
    eventType: json['eventType'] as String,
    compulsory: json['compulsory'] as String,
    teacher: json['teacher'] as String,
    courseCode: json['courseCode'] as String,
    courseNo: json['courseNo'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'eventId': eventId,
    'name': name,
    'location': location,
    'tableId': tableId,
    'colorId': colorId,
    'time': time.map((e) => e.toString()).toList(),
    'eventType': eventType,
    'compulsory': compulsory,
    'teacher': teacher,
    'courseCode': courseCode,
    'courseNo': courseNo
  };

  TeacherNameSearchResult clone() => TeacherNameSearchResult(
    eventId: eventId,
    name: name,
    location: location,
    tableId: tableId,
    colorId: colorId,
    time: time.toList(),
    eventType: eventType,
    compulsory: compulsory,
    teacher: teacher,
    courseCode: courseCode,
    courseNo: courseNo
  );


  TeacherNameSearchResult copyWith({
    int? eventId,
    String? name,
    String? location,
    String? tableId,
    int? colorId,
    List<TeacherTimeResult>? time,
    String? eventType,
    String? compulsory,
    String? teacher,
    String? courseCode,
    String? courseNo
  }) => TeacherNameSearchResult(
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    location: location ?? this.location,
    tableId: tableId ?? this.tableId,
    colorId: colorId ?? this.colorId,
    time: time ?? this.time,
    eventType: eventType ?? this.eventType,
    compulsory: compulsory ?? this.compulsory,
    teacher: teacher ?? this.teacher,
    courseCode: courseCode ?? this.courseCode,
    courseNo: courseNo ?? this.courseNo,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TeacherNameSearchResult && eventId == other.eventId && name == other.name && location == other.location && tableId == other.tableId && colorId == other.colorId && time == other.time && eventType == other.eventType && compulsory == other.compulsory && teacher == other.teacher && courseCode == other.courseCode && courseNo == other.courseNo;

  @override
  int get hashCode => eventId.hashCode ^ name.hashCode ^ location.hashCode ^ tableId.hashCode ^ colorId.hashCode ^ time.hashCode ^ eventType.hashCode ^ compulsory.hashCode ^ teacher.hashCode ^ courseCode.hashCode ^ courseNo.hashCode;
}
