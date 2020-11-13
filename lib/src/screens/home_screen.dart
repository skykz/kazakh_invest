import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazakh_invest/src/components/app_drawer_widget.dart';
import 'package:kazakh_invest/src/screens/sliders_screens.dart';
import 'package:kazakh_invest/src/core/data/models/dialog_type.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:kazakh_invest/src/screens/news_detail_screen.dart';
import 'package:kazakh_invest/src/screens/regions_list_screen.dart';
import 'package:kazakh_invest/src/screens/web_view_screen.dart';
import 'package:kazakh_invest/src/utils/common.dart';
import 'package:provider/provider.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';

import 'history_success_screen.dart';
import 'news_screen.dart';

class IntroMainScreen extends StatefulWidget {
  IntroMainScreen({Key key}) : super(key: key);

  @override
  _IntroMainScreenState createState() => _IntroMainScreenState();
}

class _IntroMainScreenState extends State<IntroMainScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset.zero)
        .animate(_controller);

    _offsetFloat.addListener(() {
      setState(() {});
    });
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getSlidersContent(context);
      homeProvider.getMainVideoData(context);
      homeProvider.getMainMenu(context);
    });

    super.initState();
  }

  List<Widget> _bodyComponents = [
    SlidersWidget(),
    NewScreen(),
    HistorySuccessScreen(),
    RegionListScreen(),
    WebViewScreen(),
    LoadingWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: homeProvider.getSliderContent == null
          ? Container(
              color: Colors.white,
              child: const Center(
                child: LoadingWidget(),
              ),
            )
          : Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                elevation: 10,
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Color.fromRGBO(35, 35, 35, 1),
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                titleSpacing: 0.0,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 350),
                      imageUrl: homeProvider.getSliderContent['logo'],
                      imageBuilder: (context, imageProvider) => Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        height: 20,
                        width: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.error_outline_rounded,
                            size: 25,
                          ),
                        ),
                      ),
                      placeholder: (context, val) => Center(
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: LoadingWidget(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'lib/assets/png/ornament.png',
                      height: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SvgPicture.asset(
                      'lib/assets/svg/kazinvest__logo.svg',
                      width: 110,
                    )
                  ],
                ),
                actions: [
                  SizedBox(
                    width: width * 0.22,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 10),
                      child: OutlineButton(
                        onPressed: () => displayCustomDialog(
                            context,
                            "Выберите язык",
                            DialogType.LangType,
                            true,
                            null,
                            () {}),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: Colors.blue,
                        child: Text(
                          setLangType(homeProvider.getLangType),
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              drawer: AppDrawer(),
              body: Consumer<HomeProvider>(builder: (context, provider, child) {
                return SlideTransition(
                  child: _bodyComponents[homeProvider.getCurrentPageIndex],
                  position: _offsetFloat,
                );
              }),
            ),
    );
  }
}

class Screen2Builder extends StatelessWidget {
  const Screen2Builder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'news',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'news':
            return MaterialPageRoute(
                builder: (context) => NewsDetailScreen(
                      isHistory: true,
                    ),
                settings: settings);
            break;

          case 'news-detail':
            return MaterialPageRoute(
                builder: (context) => WebViewScreen(), settings: settings);
            break;

          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
