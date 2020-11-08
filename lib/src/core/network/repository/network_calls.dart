import 'dart:core';

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
  static const NEWS_SUCCESS_STORY_BY_ID = '/news/success-story/getById';
  static const NEWS_GET_REGION_SECTION = '/news/getRegionSection';
  static const NEWS_GET = '/news/get';
  static const NEWS_GET_BY_ID = '/news/getById';

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

  Future<dynamic> getSliders(BuildContext context, String langtype) async {
    dynamic response = await _networkCall.doRequestMain(
        path: MAIN_SLIDERS,
        method: 'GET',
        context: context,
        requestParams: {'lang': langtype.toString()});
    return response;
  }

  Future<dynamic> getMainMenu(BuildContext context, String langtype) async {
    dynamic response = await _networkCall.doRequestMain(
        path: MENU_MAIN,
        method: 'GET',
        context: context,
        requestParams: {'lang': langtype.toString()});
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
}
