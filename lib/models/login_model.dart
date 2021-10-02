import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'time_node_model.dart';
import 'timetable_model.dart';


@immutable
class LoginModel {

  const LoginModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final Data data;

  factory LoginModel.fromJson(Map<String,dynamic> json) => LoginModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data.toJson()
  };

  LoginModel clone() => LoginModel(
    code: code,
    msg: msg,
    data: data.clone()
  );


  LoginModel copyWith({
    int? code,
    String? msg,
    Data? data
  }) => LoginModel(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LoginModel && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}

@immutable
class Data {

  const Data({
    required this.connectSuccess,
    required this.pwdRight,
    required this.id,
    required this.userInfo,
    required this.timeNodes,
    required this.accessToken,
    required this.refreshToken,
    required this.arr,
  });

  final bool connectSuccess;
  final bool pwdRight;
  final String id;
  final UserInfo userInfo;
  final List<TimeNodeModel> timeNodes;
  final String accessToken;
  final String refreshToken;
  final List<TimetableModel> arr;

  factory Data.fromJson(Map<String,dynamic> json) => Data(
    connectSuccess: json['connectSuccess'] as bool,
    pwdRight: json['pwdRight'] as bool,
    id: json['id'] as String,
    userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    timeNodes: (json['timeNodes'] as List? ?? []).map((e) => TimeNodeModel.fromJson(e as Map<String, dynamic>)).toList(),
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    arr: (json['arr'] as List? ?? []).map((e) => TimetableModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'connectSuccess': connectSuccess,
    'pwdRight': pwdRight,
    'id': id,
    'userInfo': userInfo.toJson(),
    'timeNodes': timeNodes.map((e) => e.toJson()).toList(),
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'arr': arr.map((e) => e.toJson()).toList()
  };

  Data clone() => Data(
    connectSuccess: connectSuccess,
    pwdRight: pwdRight,
    id: id,
    userInfo: userInfo.clone(),
    timeNodes: timeNodes.map((e) => e.clone()).toList(),
    accessToken: accessToken,
    refreshToken: refreshToken,
    arr: arr.map((e) => e.clone()).toList()
  );


  Data copyWith({
    bool? connectSuccess,
    bool? pwdRight,
    String? id,
    UserInfo? userInfo,
    List<TimeNodeModel>? timeNodes,
    String? accessToken,
    String? refreshToken,
    List<TimetableModel>? arr
  }) => Data(
    connectSuccess: connectSuccess ?? this.connectSuccess,
    pwdRight: pwdRight ?? this.pwdRight,
    id: id ?? this.id,
    userInfo: userInfo ?? this.userInfo,
    timeNodes: timeNodes ?? this.timeNodes,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    arr: arr ?? this.arr,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Data && connectSuccess == other.connectSuccess && pwdRight == other.pwdRight && id == other.id && userInfo == other.userInfo && timeNodes == other.timeNodes && accessToken == other.accessToken && refreshToken == other.refreshToken && arr == other.arr;

  @override
  int get hashCode => connectSuccess.hashCode ^ pwdRight.hashCode ^ id.hashCode ^ userInfo.hashCode ^ timeNodes.hashCode ^ accessToken.hashCode ^ refreshToken.hashCode ^ arr.hashCode;
}

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
