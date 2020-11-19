import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';
import 'package:kazakh_invest/src/components/main_white_card.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';

class RegionListScreen extends StatefulWidget {
  const RegionListScreen({Key key}) : super(key: key);

  @override
  _RegionListScreenState createState() => _RegionListScreenState();
}

class _RegionListScreenState extends State<RegionListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getRegionData(context);
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  setTitle(homeProvider),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            homeProvider.getMainRegionList == null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: const LoadingWidget(),
                  )
                : Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: homeProvider.getMainRegionList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3.5),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: MainCardWidget(
                              imageUrl: homeProvider.getMainRegionList[index]
                                  ['img'],
                              title: homeProvider.getMainRegionList[index]
                                  ['name'],
                              onTap: () {},
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  setTitle(HomeProvider val) {
    switch (val.getLangType) {
      case 'ru':
        return "Регионы для инвестиций";
        break;
      case 'en':
        return "Investment regions";
        break;
      case 'kz':
        return "Инвестициялық аймақтар";
        break;
      default:
        return null;
    }
  }
}
