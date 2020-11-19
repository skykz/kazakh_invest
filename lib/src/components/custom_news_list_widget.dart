import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/data/models/dialog_type.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:kazakh_invest/src/utils/common.dart';
import 'package:provider/provider.dart';

import 'news_big_card_widget.dart';

class CustomListWidget extends StatelessWidget {
  final int categoryId;
  const CustomListWidget({Key key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return FutureBuilder(
      future: homeProvider.getNewsCategoryById(categoryId, context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null)
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: Platform.isAndroid
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                  : const CupertinoActivityIndicator(
                      radius: 15,
                    ),
            ),
          );
        return ListView.builder(
            itemCount: snapshot.data.length,
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              return NewsBigCardWidget(
                onTap: () {
                  if (snapshot.data[index]['type'] != 'external') {
                    homeProvider
                        .setNewsId(int.tryParse(snapshot.data[index]['id']));
                    homeProvider.setCurrentScreenIndex(6);
                  } else {
                    displayCustomDialog(
                      context,
                      'sdfsdfdsf',
                      DialogType.WebView,
                      true,
                      null,
                      snapshot.data[index]['link'],
                      null,
                    );
                  }
                },
                imageUrl: snapshot.data[index]['picture'],
                date: snapshot.data[index]['date'].toString(),
                title: snapshot.data[index]['name'].toString(),
              );
            });
      },
    );
  }
}
