import 'package:flutter/widgets.dart';
import 'package:itime_frontend/main.dart';
import 'package:itime_frontend/pages/login_page.dart';
import 'package:rest_api_client/implementations/default/rest_api_client.dart';
import 'package:rest_api_client/options/rest_api_client_options.dart';

abstract class BaseApi {
  static RestApiClient _client = RestApiClient(
    restApiClientOptions: RestApiClientOptions(
      //Defines your base API url eg. https://mybestrestapi.com
      baseUrl: "http://116.63.196.15:8001/v1",

      //Toggle logging of your requests and responses
      //to the console while debugging
      logNetworkTraffic: true,

      //Sets the flag deciding if the instance of restApiClient should retry to
      //submit the request after the device reconnects to the network
      keepRetryingOnNetworkError: true,

      header: false,

      parameter: true,

      method: "GET",

      unauthorizedCode: 20001,

      //Define refresh token endpoint for RestApiClient
      //instance to use the first time response status code is 401
      refreshTokenEndpoint: '/user/access_token',

      //Define the name of your api parameter name
      //on RefreshToken endpoint eg. 'refreshToken' or 'value' ...
      refreshTokenParameterName: 'refreshToken',

      jwtParameterName: 'accessToken',

      //This method is called on successfull call to refreshTokenEndpoint
      //Provides a way to get a jwt from response, much like
      //resolveValidationErrorsMap callback
      resolveJwt: (response) => response.data['data']['accessToken'],

      //Much like resolveJwt, this method is used to resolve
      //refresh token from response
      resolveRefreshToken: (response) => response.data['data']['refreshToken'],

      //If your api returns validation errors different from
      //default format that is response.data['validationErrors']
      //you can override it by providing this callback
      resolveValidationErrorsMap: (response) => response,

      resolveCode: (response) => response.data['code'],

      refreshFallback: () => Routes.navigatorKey.currentState!
          .pushAndRemoveUntil(LoginPage.route(), ModalRoute.withName('/')),

      ///Set the [useCache] flag if you want save every response from GET requests
      ///and afterwards be able to use [getCached] method to retrieve local item quickly
      useCache: true,
    ),
  );

  BaseApi();

  RestApiClient get dio {
    return _client;
  }

  static Future init() async {
    await _client.init();
  }

  static Future<bool> isAuthorized() async {
    return _client.isAuthorized();
  }
}
