import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/conts/conts.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:provider/provider.dart';

class NetworkCall {
  // next three lines makes this class a Singleton
  static NetworkCall _instance = NetworkCall.internal();

  NetworkCall.internal();
  factory NetworkCall() => _instance;

  final JsonDecoder _decoder = JsonDecoder();
  dynamic _decodedRes;

  Future<dynamic> doRequestAuth(
      {@required String path,
      @required String method,
      @required BuildContext context,
      Map<String, dynamic> requestParams,
      Map<String, dynamic> body,
      FormData formData}) async {
    BaseOptions options = BaseOptions(
        baseUrl: BASE_URL, //base server url
        method: method,
        contentType: ContentType.parse("application/json").value);

    Dio dio = Dio(options);
    Response response;

    try {
      response =
          await dio.request(path, queryParameters: requestParams, data: body);

      // log(" - Response - ", name: " api route -- $path");
      // print(' ==== RESPONSE: $response');

      _decodedRes = _decoder.convert(response.toString());
      return _decodedRes;
    } on DioError catch (error) {
      handleError(error, context);
    }
  }

  Future<dynamic> doRequestMain(
      {@required String path,
      @required String method,
      @required BuildContext context,
      Map<String, dynamic> requestParams,
      Map<String, dynamic> body,
      bool isToken}) async {
    BaseOptions options;
    if (isToken != false) {
      // final value = Provider.of<UserData>(context, listen: false);
      options = BaseOptions(
        baseUrl: BASE_URL,
        method: method,
        // headers: {'Authorization': 'Bearer ' + value.accessToken},
        contentType: 'application/json',
      );
    } else {
      options = BaseOptions(
        baseUrl: BASE_URL,
        method: method,
        headers: null,
        contentType: 'application/json',
      );
    }

    Dio dio = Dio(options);
    Response response;
    try {
      response =
          await dio.request(path, queryParameters: requestParams, data: body);
      log(" - Response - ", name: " api route -- $path");
      print(" +++++ ${response.data}");
      return response.data;
    } on DioError catch (error) {
      // print(' --- req main errors +++++++++ $error');
      handleError(error, context);
    }
  }
}

/// handling avaiable cases from server
void handleError(DioError error, BuildContext context) {
  String errorDescription;

  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = 'Запрос был отменен';
        print(errorDescription);

        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = 'Попробуйте позже или перезагрузите';
        print(errorDescription);

        break;
      case DioErrorType.DEFAULT:
        errorDescription = 'Интернет-желі табылмады';
        print(errorDescription);

        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = 'Время ожидание ответа сервера истекло';
        print(errorDescription);

        break;
      case DioErrorType.RESPONSE:
        errorDescription = "Қате: " + error.response.data['error'];
        print(errorDescription);

        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = 'Время соединения истекло';
        print(errorDescription);
        break;
    }
  }

  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 20),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        action: SnackBarAction(
          label: 'ОК',
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.info_outline, color: Colors.white),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  errorDescription,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
