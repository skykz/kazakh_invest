import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:kazakh_invest/src/core/data/conts/conts.dart';

class NetworkCall {
  static NetworkCall _instance = NetworkCall.internal();

  NetworkCall.internal();
  factory NetworkCall() => _instance;

  final JsonDecoder _decoder = JsonDecoder();
  // ignore: unused_field
  dynamic _decodedRes;

  Future<dynamic> doRequestMain({
    @required String path,
    @required String method,
    @required BuildContext context,
    Map<String, dynamic> requestParams,
    Map<String, dynamic> body,
  }) async {
    BaseOptions options;

    options = BaseOptions(
      baseUrl: BASE_URL,
      method: method,
      headers: null,
      contentType: 'application/json',
    );

    Dio dio = Dio(options);
    Response response;
    try {
      response =
          await dio.request(path, queryParameters: requestParams, data: body);
      // log(" - Response - ", name: " api route -- $path");
      // log(" +++++ ${_decoder.convert(response.data.toString())}");
      return _decodedRes = _decoder.convert(response.data.toString());
    } on DioError catch (error) {
      log(' --- req main errors +++++++++ $error');
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
