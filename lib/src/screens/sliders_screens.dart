import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kazakh_invest/src/components/scale_transition_route.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';

import '../components/blur_container_widget.dart';
import '../components/bounce_button.dart';
import '../components/full_video_screen.dart';
import '../components/loading_widget.dart';

class SlidersWidget extends StatefulWidget {
  const SlidersWidget({Key key}) : super(key: key);

  @override
  _SlidersWidgetState createState() => _SlidersWidgetState();
}

class _SlidersWidgetState extends State<SlidersWidget> {
  PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Consumer<HomeProvider>(builder: (context, provider, child) {
          return CachedNetworkImage(
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 150),
            imageUrl: provider.getSliderContent['background'],
            imageBuilder: (context, imageProvider) => Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const SizedBox(
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
              height: 25,
              width: 25,
              child: LoadingWidget(),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
            return PageView(
              controller: _pageController,
              onPageChanged: (val) {
                provider.setPageIndicator(val);
              },
              children: [
                _builFirstScreen(),
                _builSecondScreen(),
                _builThirdScreen(),
              ],
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<HomeProvider>(builder: (context, provider, child) {
              return CirclePageIndicator(
                itemCount: 3,
                dotSpacing: 15,
                size: 11,
                selectedSize: 11,
                selectedDotColor: Colors.white,
                dotColor: const Color.fromRGBO(96, 182, 227, 0.45),
                currentPageNotifier: provider.getPageNotifier,
              );
            }),
          ),
        ),
      ],
    );
  }

  _builFirstScreen() {
    final height = MediaQuery.of(context).size.height;
    final homeProvider = Provider.of<HomeProvider>(context);

    return homeProvider.getSliderContent != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Text(
                  Platform.isAndroid
                      ? '${homeProvider.getSliderContent['title']}'
                      : '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      shadows: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 1,
                            color: Colors.black45)
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.2,
                child: Stack(
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          homeProvider.getMainVideo != null
                              ? '${homeProvider.getMainVideo['title']}'
                              : '....',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              shadows: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    color: Colors.black87)
                              ]),
                        ),
                      ),
                    ),
                    Center(
                      child: BouncingWidget(
                        onPressed: () => _showVideoScreen(homeProvider),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlurContainerWidget(
                      onTap: () {
                        homeProvider.setControllerNull();

                        homeProvider.setCurrentScreenIndex(4);
                        homeProvider.setWebLink(homeProvider
                            .getSliderContent['main_slider'][0]['link']);
                      },
                      svgPath: 'lib/assets/svg/layers.svg',
                      title:
                          '${homeProvider.getSliderContent['main_slider'][0]['title']}',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlurContainerWidget(
                      onTap: () {
                        homeProvider.setControllerNull();

                        homeProvider.setCurrentScreenIndex(4);
                        homeProvider.setWebLink(homeProvider
                            .getSliderContent['main_slider'][1]['link']);
                      },
                      svgPath: 'lib/assets/svg/line_chart.svg',
                      title:
                          '${homeProvider.getSliderContent['main_slider'][1]['title']}',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlurContainerWidget(
                      onTap: () {
                        homeProvider.setControllerNull();

                        homeProvider.setCurrentScreenIndex(4);
                        homeProvider.setWebLink(homeProvider
                            .getSliderContent['main_slider'][2]['link']);
                      },
                      svgPath: 'lib/assets/svg/download.svg',
                      title:
                          '${homeProvider.getSliderContent['main_slider'][2]['title']}',
                    ),
                  ],
                ),
              )
            ],
          )
        : Center(
            child: Platform.isAndroid
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                : const CupertinoActivityIndicator(
                    radius: 15,
                  ),
          );
  }

  _showVideoScreen(HomeProvider homeProvider) {
    Navigator.push(
      context,
      ScaleRoute(
        page: VideoFullScreen(
            videoLink: homeProvider.getMainVideo['video_link'].toString()),
      ),
    );
  }

  _builSecondScreen() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          homeProvider.getSliderContent['secondry_slider'][0]
                              ['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          homeProvider.getSliderContent['secondry_slider'][0]
                              ['sub_title'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        homeProvider.getSliderContent['secondry_slider'][0]
                            ['content'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          homeProvider.getSliderContent['secondry_slider'][1]
                              ['title'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          homeProvider.getSliderContent['secondry_slider'][1]
                              ['sub_title'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        homeProvider.getSliderContent['secondry_slider'][1]
                            ['content'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            homeProvider.getSliderContent['secondry_slider'][2]
                                ['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 150),
                            imageUrl:
                                "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: const SizedBox(
                                height: 60,
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, val) => Center(
                              child: const SizedBox(
                                height: 20,
                                width: 20,
                                child: LoadingWidget(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    homeProvider
                                            .getSliderContent['secondry_slider']
                                        [2]['content'],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Center(
                                    child: OutlineButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hoverColor: Colors.white,
                                      borderSide: BorderSide(
                                        color: Colors.grey[500],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: const Text(
                                        "Подробнее",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (homeProvider
                                                .getSliderContent[
                                                    'secondry_slider'][2]
                                                    ['link']
                                                .length !=
                                            0) {
                                          homeProvider.setControllerNull();

                                          homeProvider.setCurrentScreenIndex(4);
                                          homeProvider.setWebLink(homeProvider
                                                  .getSliderContent[
                                              'secondry_slider'][2]['link']);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _builThirdScreen() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width * 0.4;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50, top: 20),
            child: Text(
              '${homeProvider.getSliderContent['secondry_title']}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  shadows: [
                    BoxShadow(
                        blurRadius: 10, spreadRadius: 1, color: Colors.black45)
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
          homeProvider.getSliderContent['items'] != null
              ? Expanded(
                  child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: homeProvider.getSliderContent['items'].length,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homeProvider.getSliderContent['items']
                                          [index]['VALUE'],
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      homeProvider.getSliderContent['items']
                                          [index]['DESC'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: 8,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              : const Center(
                  child: Text('Нету данных.'),
                ),
        ],
      ),
    );
  }
}
