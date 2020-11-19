import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'expansion_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Drawer(
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: SvgPicture.asset(
              'lib/assets/svg/big_ornament.svg',
              color: Color.fromRGBO(227, 243, 255, 1),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.06, bottom: height * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: provider.getMainMenuData.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final GlobalKey<AppExpansionTileState>
                                  expansionTile = new GlobalKey();
                              return AppExpansionTile(
                                key: expansionTile,
                                itemIndex: index,
                                isEmpty: provider.getMainMenuData[index]
                                            ['submenu'] ==
                                        null
                                    ? true
                                    : false,
                                onTapped: () {
                                  if (provider.getMainMenuData[index]['code'] ==
                                      'cmd://regions') {
                                    provider.setCurrentScreenIndex(3);
                                    provider.setMenuItemIndex(index);
                                    Navigator.of(context).pop();
                                  }
                                },
                                selectedItemIndex: provider.getMenuItemIndex,
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text(
                                      provider.getMainMenuData[index]['title'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                backgroundColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.025),
                                child: ListView.builder(
                                    key: Key('$index'),
                                    itemCount: provider.getMainMenuData[index]
                                                ['submenu'] !=
                                            null
                                        ? provider
                                            .getMainMenuData[index]['submenu']
                                            .length
                                        : 0,
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    itemExtent: 40,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) {
                                      return Row(
                                        key: Key('$i'),
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                ),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  provider
                                                      .setMenuItemIndex(index);
                                                  _switchScreen(
                                                      provider, index, i);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 50,
                                                    top: 10,
                                                    bottom: 10,
                                                  ),
                                                  child: Text(
                                                    provider.getMainMenuData[
                                                            index]['submenu'][i]
                                                        ['title'],
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.22),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: SvgPicture.asset(
                                    'lib/assets/svg/phone.svg',
                                    width: 20,
                                  ),
                                ),
                                const Text(
                                  '+7 7172 620 620',
                                  style: TextStyle(
                                    color: Color.fromRGBO(75, 75, 75, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: Color.fromRGBO(96, 182, 227, 1),
                                    onPressed: () {
                                      launch('tel://+77172620620');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: FittedBox(
                                        child: Text(
                                          setPhoneString(context),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _switchScreen(HomeProvider provider, int index, int i) {
    if (provider.getMainMenuData[index]['submenu'][i]['link'] == 'cmd://news') {
      provider.setCurrentScreenIndex(1);
    } else if (provider.getMainMenuData[index]['submenu'][i]['link'] ==
        'cmd://success-stories') {
      provider.setCurrentScreenIndex(2);
    } else {
      provider.setControllerNull();

      // provider.setCurrentScreenIndex(5);
      provider
          .setWebLink(provider.getMainMenuData[index]['submenu'][i]['link']);
      provider.setCurrentScreenIndex(4);
    }
  }

  String setPhoneString(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    switch (homeProvider.getLangType) {
      case 'ru':
        return "Направить запрос";
        break;
      case 'en':
        return "Send request";
        break;
      case 'kz':
        return "Сұраныс жіберу";
        break;
      default:
        return null;
    }
  }
}
