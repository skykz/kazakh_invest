import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/network/core/api_network.dart';

class KazakhInvestOpenApi {
  static KazakhInvestOpenApi _instance = KazakhInvestOpenApi.internal();
  KazakhInvestOpenApi.internal();
  factory KazakhInvestOpenApi() => _instance;

  NetworkCall _networkCall = NetworkCall();

  // Menu
  static const MENU_MAIN = '/menu/main/get';
  static const MENU_SUB_MENU = '/menu/main/get/submenu';
  static const MENU_REGION_MENU = '/menu/main/get/region';
  static const MENU_REGION_SUB_MENU = '/menu/main/get/region/submenu';

  // News
  static const NEWS_SUCCESS_STORY = '/news/success-story';
  static const NEWS_SUCCESS_STORY_REGION = '/news/success-story/region';
  static const NEWS_SUCCESS_STORY_BY_ID = '/news/success-story/getById';
  static const NEWS_SUCCESS_STORY_REGIO_BY_ID =
      '/news/success-story/region/getById';
  static const NEWS_GET_REGION_SECTION = '/news/getRegionSection';
  static const NEWS_GET = '/news/get';
  static const NEWS_GET_BY_ID = '/news/getById';
  static const NEWS_GET_BY_CATEGORY = '/news/getByCategory';
  static const NEWS_GET_CATEGORY = '/news/categories';

  // Regions
  static const REGION_GET = '/regions/get';

  // Invest Guide
  static const INVEST_GUIDE = '/invest-guide/arrival';

  // Pages
  static const MAIN_PAGES = '/pages/get';

  // Main sliders
  static const MAIN_SLIDERS = '/sliders/main';

  //Video
  static const GET_VIDEO = '/main/video';

  //Our secret Api
  static const DO_SECRET_API = '/secret';

  Future<dynamic> getSecret(BuildContext context) async {
    dynamic response = await _networkCall.doRequestMain(
      path: DO_SECRET_API,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getSliders(
      BuildContext context, String langtype, String codeRegion) async {
    dynamic response = await _networkCall.doRequestMain(
        path: MAIN_SLIDERS,
        method: 'GET',
        context: context,
        requestParams: codeRegion == null
            ? {
                'lang': langtype.toString(),
              }
            : {
                'lang': langtype.toString(),
                'region_code': codeRegion,
              });
    return response;
  }

  Future<dynamic> getMainMenu(
      BuildContext context, String langtype, String codeRegion) async {
    dynamic response = await _networkCall.doRequestMain(
        path: codeRegion == null ? MENU_MAIN : MENU_REGION_MENU,
        method: 'GET',
        context: context,
        requestParams: codeRegion == null
            ? {
                'lang': langtype.toString(),
              }
            : {
                'lang': langtype.toString(),
                'region_code': codeRegion,
              });
    return response;
  }

  Future<dynamic> getSubMenu(BuildContext context, String langtype) async {
    dynamic response = await _networkCall.doRequestMain(
        path: MENU_SUB_MENU,
        method: 'GET',
        context: context,
        requestParams: {'lang': langtype.toString()});
    return response;
  }

  Future<dynamic> getMainVideo(BuildContext context, String langtype) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_VIDEO,
        method: 'GET',
        context: context,
        requestParams: {'lang': langtype.toString()});

    return response;
  }

  Future<dynamic> getRegionList(BuildContext context, String langtype) async {
    dynamic response = await _networkCall.doRequestMain(
        path: REGION_GET,
        method: 'GET',
        context: context,
        requestParams: {'lang': langtype.toString()});

    return response;
  }

  Future<dynamic> getSuccessHistory(
      BuildContext context, String langtype, String codeRegion) async {
    log('$langtype');
    dynamic response = await _networkCall.doRequestMain(
      path: codeRegion == null ? NEWS_SUCCESS_STORY : NEWS_SUCCESS_STORY_REGION,
      method: 'GET',
      context: context,
      requestParams: codeRegion == null
          ? {'lang': langtype.toString()}
          : {
              'lang': langtype.toString(),
              'region_code': codeRegion,
            },
    );

    return response;
  }

  Future<dynamic> getCategeoryNews(
      BuildContext context, String langtype, String _regionCode) async {
    dynamic response = await _networkCall.doRequestMain(
        path: NEWS_GET_CATEGORY,
        method: 'GET',
        context: context,
        requestParams: {
          'lang': langtype.toString(),
          'region_code': _regionCode,
        });

    return response;
  }

  Future<dynamic> getCategoryById(
      BuildContext context, String langtype, int categoryId) async {
    dynamic response = await _networkCall.doRequestMain(
        path: NEWS_GET_BY_CATEGORY,

        ///getByCategory
        method: 'GET',
        context: context,
        requestParams: {
          'lang': langtype.toString(),
          'category_id': categoryId,
        });

    return response;
  }

  Future<dynamic> getSuccessHistoryById(
      BuildContext context, String langtype, int id, String codeRegion) async {
    dynamic response = await _networkCall.doRequestMain(
        path: codeRegion == null
            ? NEWS_SUCCESS_STORY_BY_ID
            : NEWS_SUCCESS_STORY_REGIO_BY_ID,
        method: 'GET',
        context: context,
        requestParams: codeRegion == null
            ? {
                'lang': langtype.toString(),
                'id': id,
              }
            : {
                'lang': langtype.toString(),
                'id': id,
              });

    return response;
  }

  Future<dynamic> getNewsDetailById(
      BuildContext context, String langtype, int id, String _regionCode) async {
    dynamic response = await _networkCall.doRequestMain(
        path: NEWS_GET_BY_ID,
        method: 'GET',
        context: context,
        requestParams: {
          'lang': langtype.toString(),
          'id': id,
          'region_code': _regionCode,
        });

    return response;
  }
}
