import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HistorySuccessDetailScreen extends StatefulWidget {
  HistorySuccessDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<HistorySuccessDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context);

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        homeProvider.setCurrentScreenIndex(2);
      },
      child: FutureBuilder(
        future: homeProvider.getSuccessHistoryById(
            homeProvider.getSuccesHistoryId, context),
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
          return Scaffold(
            backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: snapshot.data['logo'] != null
                          ? CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 150),
                              imageUrl: snapshot.data['logo'],
                              imageBuilder: (context, imageProvider) => Center(
                                child: Container(
                                  height: height * 0.18,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      alignment: Alignment.centerLeft,
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const SizedBox(
                                height: 30,
                                width: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.error_outline_rounded,
                                    size: 25,
                                  ),
                                ),
                              ),
                              placeholder: (context, val) => const SizedBox(
                                height: 30,
                                width: 30,
                                child: const LoadingWidget(),
                              ),
                            )
                          : SizedBox(
                              height: height * 0.18,
                              width: width * 0.5,
                              child: const Icon(
                                Icons.no_photography,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    Text(
                      snapshot.data['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Html(
                        data: snapshot.data['detail'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
