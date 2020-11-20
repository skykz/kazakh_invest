import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';
import 'package:kazakh_invest/src/components/main_white_card.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HistorySuccessScreen extends StatefulWidget {
  const HistorySuccessScreen({Key key}) : super(key: key);

  @override
  _RegionListScreenState createState() => _RegionListScreenState();
}

class _RegionListScreenState extends State<HistorySuccessScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getSuccessHistoryData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return WillPopScope(
      onWillPop: () {
        homeProvider.setCurrentScreenIndex(0);
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: const Color.fromRGBO(246, 246, 246, 1),
              padding: const EdgeInsets.symmetric(vertical: 30),
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
            homeProvider.getMainSuccessHistoryList == null
                ? const LoadingWidget()
                : homeProvider.getMainSuccessHistoryList.length == 0
                    ? Column(
                        children: [
                          Center(
                            child: const Text(
                              'Нету данных!',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                homeProvider.getMainSuccessHistoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: MainCardWidget(
                                  imageUrl: homeProvider
                                      .getMainSuccessHistoryList[index]['logo'],
                                  title: homeProvider
                                      .getMainSuccessHistoryList[index]['name'],
                                  isBigCard: true,
                                  onTap: () {
                                    homeProvider.setSuccesHistoryId(
                                      int.tryParse(
                                        homeProvider.getMainSuccessHistoryList[
                                            index]['id'],
                                      ),
                                    );
                                    homeProvider.setCurrentScreenIndex(5);
                                  },
                                ),
                              );
                            }),
                      )
          ],
        ),
      ),
    );
  }

  setTitle(HomeProvider val) {
    switch (val.getLangType) {
      case 'ru':
        return "Истории успеха";
        break;
      case 'en':
        return "History of success";
        break;
      case 'kz':
        return "Жетістік тарихы";
        break;
      default:
        return null;
    }
  }
}
