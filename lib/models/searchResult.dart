import 'package:flutter/foundation.dart';
import 'courseNameSearchResult.dart';
import 'teacherNameSearchResult.dart';
import 'locationSearchResult.dart';
import 'classIdSearchResult.dart';

@immutable
class SearchResult {

  const SearchResult({
    required this.courseNameSearchResult,
    required this.teacherNameSearchResult,
    required this.locationSearchResult,
    required this.classIdSearchResult,
  });

  final List<CourseNameSearchResult> courseNameSearchResult;
  final List<TeacherNameSearchResult> teacherNameSearchResult;
  final List<LocationSearchResult> locationSearchResult;
  final List<ClassIdSearchResult> classIdSearchResult;

  factory SearchResult.fromJson(Map<String,dynamic> json) => SearchResult(
    courseNameSearchResult: (json['courseNameSearchResult'] as List? ?? []).map((e) =>  CourseNameSearchResult.fromJson(e)).toList(),
    teacherNameSearchResult: (json['teacherNameSearchResult'] as List? ?? []).map((e) => TeacherNameSearchResult.fromJson(e)).toList(),
    locationSearchResult: (json['locationSearchResult'] as List? ?? []).map((e) => LocationSearchResult.fromJson(e)).toList(),
    classIdSearchResult: (json['classIdSearchResult'] as List? ?? []).map((e) => ClassIdSearchResult.fromJson(e)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'courseNameSearchResult': courseNameSearchResult.map((e) => e.toString()).toList(),
    'teacherNameSearchResult': teacherNameSearchResult.map((e) => e.toString()).toList(),
    'locationSearchResult': locationSearchResult.map((e) => e.toString()).toList(),
    'classIdSearchResult': classIdSearchResult.map((e) => e.toString()).toList()
  };

  SearchResult clone() => SearchResult(
    courseNameSearchResult: courseNameSearchResult.toList(),
    teacherNameSearchResult: teacherNameSearchResult.toList(),
    locationSearchResult: locationSearchResult.toList(),
    classIdSearchResult: classIdSearchResult.toList()
  );


  SearchResult copyWith({
    List<CourseNameSearchResult>? courseNameSearchResult,
    List<TeacherNameSearchResult>? teacherNameSearchResult,
    List<LocationSearchResult>? locationSearchResult,
    List<ClassIdSearchResult>? classIdSearchResult
  }) => SearchResult(
    courseNameSearchResult: courseNameSearchResult ?? this.courseNameSearchResult,
    teacherNameSearchResult: teacherNameSearchResult ?? this.teacherNameSearchResult,
    locationSearchResult: locationSearchResult ?? this.locationSearchResult,
    classIdSearchResult: classIdSearchResult ?? this.classIdSearchResult,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SearchResult && courseNameSearchResult == other.courseNameSearchResult && teacherNameSearchResult == other.teacherNameSearchResult && locationSearchResult == other.locationSearchResult && classIdSearchResult == other.classIdSearchResult;

  @override
  int get hashCode => courseNameSearchResult.hashCode ^ teacherNameSearchResult.hashCode ^ locationSearchResult.hashCode ^ classIdSearchResult.hashCode;
}
