import 'package:flutter/foundation.dart';
import 'searchResult.dart';

@immutable
class SearchResultResponse {

  const SearchResultResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  final int code;
  final String msg;
  final SearchResult data;

  factory SearchResultResponse.fromJson(Map<String,dynamic> json) => SearchResultResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: SearchResult.fromJson(json['data'])
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data
  };

  SearchResultResponse clone() => SearchResultResponse(
    code: code,
    msg: msg,
    data: data
  );


  SearchResultResponse copyWith({
    int? code,
    String? msg,
    SearchResult? data
  }) => SearchResultResponse(
    code: code ?? this.code,
    msg: msg ?? this.msg,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SearchResultResponse && code == other.code && msg == other.msg && data == other.data;

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}
