import 'package:flutter/foundation.dart';
import 'userInfo.dart';
import 'tableResult.dart';

@immutable
class LoginResult {

  const LoginResult({
    required this.connectSuccess,
    required this.pwdRight,
    required this.id,
    required this.userInfo,
    required this.accessToken,
    required this.refreshToken,
    required this.arr,
  });

  final bool connectSuccess;
  final bool pwdRight;
  final String id;
  final UserInfo userInfo;
  final String accessToken;
  final String refreshToken;
  final List<TableResult> arr;

  factory LoginResult.fromJson(Map<String,dynamic> json) => LoginResult(
    connectSuccess: json['connectSuccess'] as bool,
    pwdRight: json['pwdRight'] as bool,
    id: json['id'] as String,
    userInfo: UserInfo.fromJson(json['userInfo']),
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    arr: (json['arr'] as List? ?? []).map((e) => TableResult.fromJson(e)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'connectSuccess': connectSuccess,
    'pwdRight': pwdRight,
    'id': id,
    'userInfo': userInfo,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'arr': arr.map((e) => e.toString()).toList()
  };

  LoginResult clone() => LoginResult(
    connectSuccess: connectSuccess,
    pwdRight: pwdRight,
    id: id,
    userInfo: userInfo,
    accessToken: accessToken,
    refreshToken: refreshToken,
    arr: arr.toList()
  );


  LoginResult copyWith({
    bool? connectSuccess,
    bool? pwdRight,
    String? id,
    UserInfo? userInfo,
    String? accessToken,
    String? refreshToken,
    List<TableResult>? arr
  }) => LoginResult(
    connectSuccess: connectSuccess ?? this.connectSuccess,
    pwdRight: pwdRight ?? this.pwdRight,
    id: id ?? this.id,
    userInfo: userInfo ?? this.userInfo,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    arr: arr ?? this.arr,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LoginResult && connectSuccess == other.connectSuccess && pwdRight == other.pwdRight && id == other.id && userInfo == other.userInfo && accessToken == other.accessToken && refreshToken == other.refreshToken && arr == other.arr;

  @override
  int get hashCode => connectSuccess.hashCode ^ pwdRight.hashCode ^ id.hashCode ^ userInfo.hashCode ^ accessToken.hashCode ^ refreshToken.hashCode ^ arr.hashCode;
}
