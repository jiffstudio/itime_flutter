import 'package:flutter/foundation.dart';
import 'loginResult.dart';

@immutable
class LoginResultResponse {

  const LoginResultResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final LoginResult data;

  factory LoginResultResponse.fromJson(Map<String,dynamic> json) => LoginResultResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: LoginResult.fromJson(json['data'])
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data
  };

  LoginResultResponse clone() => LoginResultResponse(
    code: code,
    msg: msg,
    data: data
  );


  LoginResultResponse copyWith({
    int? code,
    String? msg,
    LoginResult? data
  }) => LoginResultResponse(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LoginResultResponse && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}
