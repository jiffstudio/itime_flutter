import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class TokenModel {

  const TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.studentId,
    required this.password,
  });

  final String accessToken;
  final String refreshToken;
  final String studentId;
  final String password;

  factory TokenModel.fromJson(Map<String,dynamic> json) => TokenModel(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    studentId: json['studentId'] as String,
    password: json['password'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'studentId': studentId,
    'password': password
  };

  TokenModel clone() => TokenModel(
    accessToken: accessToken,
    refreshToken: refreshToken,
    studentId: studentId,
    password: password
  );


  TokenModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? studentId,
    String? password
  }) => TokenModel(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    studentId: studentId ?? this.studentId,
    password: password ?? this.password,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TokenModel && accessToken == other.accessToken && refreshToken == other.refreshToken && studentId == other.studentId && password == other.password;

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode ^ studentId.hashCode ^ password.hashCode;
}
