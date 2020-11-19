import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/custom_news_list_widget.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () {
        homeProvider.setCurrentScreenIndex(0);
      },
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: homeProvider.getNewsCategory(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null)
                return Center(
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: Platform.isAndroid
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : const CupertinoActivityIndicator(
                            radius: 15,
                          ),
                  ),
                );
              List<dynamic> _listCategories = snapshot.data;
              _tabController =
                  TabController(length: _listCategories.length, vsync: this);
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        setTitle(homeProvider),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor:
                                const Color.fromRGBO(96, 182, 227, 1),
                            labelColor: Colors.black,
                            controller: _tabController,
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            tabs: _listCategories.map((data) {
                              return Tab(text: '${data['title']}');
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: _listCategories.map((data) {
                          return CustomListWidget(
                            categoryId: data['id'],
                          );
                        }).toList()),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  setTitle(HomeProvider val) {
    switch (val.getLangType) {
      case 'ru':
        return "Новости";
        break;
      case 'en':
        return "News";
        break;
      case 'kz':
        return "Жаңалықтар";
        break;
      default:
        return null;
    }
  }
}
