import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/network/core/api_network.dart';

class BilimAPI {
  static BilimAPI _instance = BilimAPI.internal();
  BilimAPI.internal();
  factory BilimAPI() => _instance;

  NetworkCall _networkCall = NetworkCall();

  // registration VK, CITI API
  static const GET_CITY = '/vk/cities';

  // auth API
  static const REGISTER_USER_WITH_DATA = '/auth/register';
  static const CHECK_EMAIL_CODE = '/auth/code';
  static const AUTH = '/auth/login';

  //Home screen
  static const GET_DESCIPLINE = '/discipline';
  static const GET_TOP_USERS = '/top/users';
  static const GET_USER_PROFILE = '/user/info';

  // Descipline or Subjects
  static const GET_ALL_VARIANTS_OF_DECIPLINE = '/discipline/';
  static const GET_QUESTIONS_OF_DISCIPLINE = '/question';
  static const GET_VARIANT_QUESTION = '/question';
  static const SEND_REPORT_WITH_QUESTION = '/question/report/';
  static const NOTE_VARIANT_PASSED = '/user/variant/';

  //report and feedbacks
  static const SEND_FEEDBACK = '/common/feedback';

  // current app version check
  static const CHECK_APP_VERSION = '/common/version';
  static const SEND_USER_FCM_TOKEN = '/common/fcm';

  // sreach question from general database
  static const SEARCH_QUESTION = '/baza/questions/';
  static const ADD_QUESTION_BY_USERS = '/baza/user/add/';

  Future<dynamic> verifySmsCodeFromEmail(String email, String code,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: CHECK_EMAIL_CODE,
      method: 'POST',
      context: context,
      body: {
        'email': email,
        'code': code,
      },
    );
    return response;
  }

  Future<dynamic> authMain(String email, String userToken, bool isGoogle,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: AUTH,
      method: 'POST',
      context: context,
      body: isGoogle
          ? {
              'email': email,
              'token': userToken,
            }
          : {'email': email},
    );
    return response;
  }

  Future<dynamic> checkAppVersion(String version,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: CHECK_APP_VERSION,
      method: 'POST',
      context: context,
      body: {'version': version},
    );
    return response;
  }

  Future<dynamic> sendFcmTokenUser(String fcmToken,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: SEND_USER_FCM_TOKEN,
      method: 'POST',
      context: context,
      body: {'fcm': fcmToken},
    );
    return response;
  }

  Future<dynamic> setUserPassesVariant(int varId,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: NOTE_VARIANT_PASSED + "$varId",
      method: 'POST',
      context: context,
    );
    return response;
  }

  Future<dynamic> getUserProfile([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_USER_PROFILE, method: 'GET', context: context);
    return response;
  }

  Future<dynamic> setRegistrationData(String username, String email,
      String cityName, int cityId, String fcmToken,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: REGISTER_USER_WITH_DATA,
        method: 'POST',
        context: context,
        isToken: false,
        body: {
          "username": username,
          "email": email,
          "city_name": cityName,
          "city_id": cityId,
          "firebase_token": fcmToken
        });
    return response;
  }

  Future<dynamic> getCities(String name, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_CITY,
      method: 'GET',
      context: context,
      isToken: false,
      requestParams: {'text': name},
    );
    return response;
  }

  Future<dynamic> getDiscipline([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_DESCIPLINE,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getVariantsOfDecipline(int desciplineId,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_ALL_VARIANTS_OF_DECIPLINE + "$desciplineId",
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getTopUsers([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_TOP_USERS,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> sendQuestionReport(int questionId, String text,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: SEND_REPORT_WITH_QUESTION + "$questionId",
      method: 'POST',
      body: {
        'text': text,
      },
      context: context,
    );
    return response;
  }

  Future<dynamic> getQuestionsDescipline(int disaName,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_QUESTIONS_OF_DISCIPLINE,
        method: 'GET',
        context: context,
        requestParams: {'discipline_id': disaName});
    return response;
  }

  Future<dynamic> getQuestionsVariant(int varId, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_VARIANT_QUESTION + "/$varId",
      method: 'GET',
      context: context,
    );
    return response;
  }

  ///send feedbacks
  Future<dynamic> sendFeedback(String fullName, String email, String text,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: SEND_FEEDBACK,
      method: 'POST',
      body: {
        'full_name': fullName,
        'email': email,
        'feedback_text': text,
      },
      context: context,
    );
    return response;
  }

  Future<dynamic> getSearchQuestion(int disaName, String text, int page,
      [BuildContext context]) async {
    // log("$disaName");
    // log("$text");
    // log("$page");

    dynamic response = await _networkCall.doRequestMain(
      path: SEARCH_QUESTION + "$disaName",
      method: 'GET',
      context: context,
      requestParams: {'text': text, 'page': page},
    );

    return response;
  }

  Future<dynamic> addQuestionByUser(
      int disaName, String question, String answer, String link,
      [BuildContext context]) async {
    log('$disaName');
    log('$question');
    log('$answer');
    log('$link');

    dynamic response = await _networkCall.doRequestMain(
      path: ADD_QUESTION_BY_USERS + "$disaName",
      method: 'POST',
      body: {'question': question, 'answer': answer, 'link': link},
      context: context,
    );
    return response;
  }
}
