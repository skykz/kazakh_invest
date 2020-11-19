import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/data/models/dialog_type.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:kazakh_invest/src/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomActionDialog extends StatefulWidget {
  final String title;
  final Function onPressed;
  final String cancelOptionText;
  final DialogType dialogType;
  final Color color;
  final String confirmOptionText;
  final Widget container;
  final String link;

  CustomActionDialog({
    @required this.title,
    @required this.onPressed,
    @required this.dialogType,
    this.color,
    this.container,
    this.link,
    this.cancelOptionText,
    this.confirmOptionText,
  });

  @override
  _CustomActionDialogState createState() => _CustomActionDialogState();
}

class _CustomActionDialogState extends State<CustomActionDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: _setDialogType(widget.dialogType, context),
    );
  }

  Widget _setDialogType(DialogType val, BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    switch (val) {
      case DialogType.LangType:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                setTitle(homeProvider),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.grey[300],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Image.asset(
                            'lib/assets/png/kz.png',
                            width: 40,
                            height: 20,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          onTap: () {
                            homeProvider.setLangType('kz');
                            _setLangType();
                            homeProvider.setCurrentScreenIndex(0);
                          },
                          title: const Text(
                            'Қазақша',
                            style: TextStyle(),
                          ),
                          trailing: homeProvider.getLangType == 'kz'
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.blueAccent,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.grey[300],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Image.asset(
                            'lib/assets/png/ru.png',
                            width: 40,
                            height: 20,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          onTap: () {
                            homeProvider.setLangType('ru');
                            _setLangType();
                            homeProvider.setCurrentScreenIndex(0);
                          },
                          title: const Text(
                            'Русский',
                            style: TextStyle(),
                          ),
                          trailing: homeProvider.getLangType == 'ru'
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.blueAccent,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.grey[300],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Image.asset(
                            'lib/assets/png/en.png',
                            width: 40,
                            height: 20,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          onTap: () {
                            homeProvider.setLangType('en');
                            _setLangType();
                            homeProvider.setCurrentScreenIndex(0);
                          },
                          title: const Text(
                            'English',
                            style: TextStyle(),
                          ),
                          trailing: homeProvider.getLangType == 'en'
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.blueAccent,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case DialogType.WebView:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                setLinkTitle(homeProvider),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  color: Colors.grey[400],
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Colors.green[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onPressed: () {
                    launch(widget.link);
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Open',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
        break;
      default:
        return const SizedBox();
    }
  }

  _setLangType() {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return IntroMainScreen();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }

  setTitle(HomeProvider val) {
    switch (val.getLangType) {
      case 'ru':
        return "Выберите язык";
        break;
      case 'en':
        return "Select language";
        break;
      case 'kz':
        return "Тілді таңданыз";
        break;
      default:
        return null;
    }
  }

  setLinkTitle(HomeProvider val) {
    switch (val.getLangType) {
      case 'ru':
        return "Хотите открыть этот пост на браузере?";
        break;
      case 'en':
        return "Want to open this post on a browser?";
        break;
      case 'kz':
        return "Бұл сілтемені Браузерде ашқыңыз келе ме?";
        break;
      default:
        return null;
    }
  }
}
