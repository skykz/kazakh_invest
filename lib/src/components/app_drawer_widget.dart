import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'expansion_widget.dart';

class AppDrawer extends StatefulWidget {
  final Function onTap;
  const AppDrawer({Key key, this.onTap}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
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
              icon: Icon(
                Icons.close_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
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

                              // return Row(
                              //   children: [
                              //     Expanded(
                              //       child: Container(
                              //         height: 50,
                              //         decoration: BoxDecoration(
                              //           border: Border(
                              //             left: BorderSide(
                              //               color: index !=
                              //                       provider.getCurrentPageIndex
                              //                   ? Colors.transparent
                              //                   : Color.fromRGBO(
                              //                       96, 182, 227, 1),
                              //               width: 5,
                              //             ),
                              //           ),
                              //         ),
                              //         child: InkWell(
                              //           onTap: () {
                              //             provider.setCurrentScreenIndex(index);
                              //             Navigator.of(context).pop();
                              //           },
                              //           child: Center(
                              //             child: Align(
                              //               alignment: Alignment.centerLeft,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 45),
                              //                 child: Text(
                              // provider.getMainMenuData[index]
                              //     ['title'],
                              //                   style: TextStyle(
                              //                     color: Colors.black,
                              //                   ),
                              //                   maxLines: 1,
                              //                   overflow: TextOverflow.ellipsis,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // );
                              return AppExpansionTile(
                                key: expansionTile,
                                title: Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 45),
                                      child: Text(provider
                                          .getMainMenuData[index]['title']),
                                    ),
                                  ),
                                ),
                                backgroundColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.025),
                                children: ListView.builder(
                                    itemCount: provider
                                        .getMainMenuData[index]['submenu']
                                        .length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: index !=
                                                            provider
                                                                .getCurrentPageIndex
                                                        ? Colors.transparent
                                                        : Color.fromRGBO(
                                                            96, 182, 227, 1),
                                                    width: 5,
                                                  ),
                                                ),
                                              ),
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    expansionTile.currentState
                                                        .collapse();
                                                  });
                                                },
                                                child: Text(
                                                  provider.getMainMenuData[
                                                          index]['submenu'][i]
                                                      ['title'],
                                                  textAlign: TextAlign.center,
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
                    padding: const EdgeInsets.only(top: 200),
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
                                      child: Text(
                                        'Направить запрос',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
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
}
