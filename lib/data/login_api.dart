// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../logger.dart';
// import '../model/canteen.dart';
// import '../utils/date_utils.dart';
// import '../utils/json_util.dart';
// import 'base_api.dart';

// class LoginApi extends BaseApi {
//   static final LoginApi _instance = LoginApi._();

//   LoginApi._()
//       : super(
//           baseUrl: 'https://tum-dev.github.io/eat-api/stubistro-rosenheim/',
//           cacheDbName: 'login_cache',
//           defaultMaxAge: Duration(days: 1),
//           defaultMaxStale: Duration(days: 7),
//         );

//   factory LoginApi() {
//     return _instance;
//   }

//   Future<LoginResultResponse?> login({
//     required String studentId,
//     required String pwd,
//   }) async {
//     final now = DateTime.now();
//     week = week ?? now.weekOfYear;

//     final url = '';

//     try {
//       final response = await dio.get(url, queryParameters: {
//         "studentId": studentId,
//         "pwd": pwd
//       });
//       final json = await parseJsonInBackground(utf8.decode(response.data));
//       return LoginResultResponse.fromJson(json);
//     } on Exception catch (_) {
//       logger.e('Error getting LoginResultResponse from EatApi.\n$url');
//       return null;
//     }
//   }
// }