import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final homeProvider = Provider.of<HomeProvider>(context);
    log("${homeProvider.getSelectedNewsId}");
    return WillPopScope(
      onWillPop: () {
        homeProvider.setCurrentScreenIndex(1);
      },
      child: FutureBuilder(
        future: homeProvider.getNewsDetailById(
            homeProvider.getSelectedNewsId, context),
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
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: height * 0.33,
                    floating: false,
                    stretch: true,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${snapshot.data['name']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black54,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      background: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 350),
                        imageUrl: '${snapshot.data['picture']}',
                        imageBuilder: (context, imageProvider) => Container(
                          height: height * 0.33,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(
                          height: 20,
                          width: 20,
                          child: const Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                        placeholder: (context, val) => const LoadingWidget(),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Html(
                      data: '${snapshot.data['detail']}',
                      showImages: true,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
