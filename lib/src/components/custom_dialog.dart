import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/data/models/dialog_type.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:kazakh_invest/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

class CustomActionDialog extends StatefulWidget {
  final String title;
  final Function onPressed;
  final String cancelOptionText;
  final DialogType dialogType;
  final Color color;
  final String confirmOptionText;
  final Widget container;

  CustomActionDialog({
    @required this.title,
    @required this.onPressed,
    @required this.dialogType,
    this.color,
    this.container,
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
                this.widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
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
                          },
                          title: Text(
                            'Қазақша',
                            style: TextStyle(),
                          ),
                          trailing: homeProvider.getLangType == 'kz'
                              ? Icon(
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
                          },
                          title: Text(
                            'Русский',
                            style: TextStyle(),
                          ),
                          trailing: homeProvider.getLangType == 'ru'
                              ? Icon(
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
                          },
                          title: Text(
                            'English',
                            style: TextStyle(),
                          ),
                          trailing: homeProvider.getLangType == 'en'
                              ? Icon(
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
}
