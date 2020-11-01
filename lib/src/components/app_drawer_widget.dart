import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazakh_invest/src/utils/common.dart';

import 'expansion_widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String foos = 'One';
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
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppExpansionTile(
                        key: expansionTile,
                        title: Center(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Text('О Казахстане'),
                            ),
                          ),
                        ),
                        backgroundColor:
                            Theme.of(context).accentColor.withOpacity(0.025),
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color.fromRGBO(96, 182, 227, 1),
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        this.foos = 'One';
                                        expansionTile.currentState.collapse();
                                      });
                                    },
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color.fromRGBO(96, 182, 227, 1),
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        this.foos = 'One';
                                        expansionTile.currentState.collapse();
                                      });
                                    },
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color.fromRGBO(96, 182, 227, 1),
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        this.foos = 'One';
                                        expansionTile.currentState.collapse();
                                      });
                                    },
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color.fromRGBO(96, 182, 227, 1),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color.fromRGBO(96, 182, 227, 1),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color.fromRGBO(96, 182, 227, 1),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color.fromRGBO(96, 182, 227, 1),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text('О Казахстане'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                color: Color.fromRGBO(96, 182, 227, 1),
                                onPressed: () {
                                  launch('tel://+77172620620');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
