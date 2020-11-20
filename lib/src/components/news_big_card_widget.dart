import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class NewsBigCardWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String date;
  final Function onTap;
  const NewsBigCardWidget(
      {Key key, this.title, this.imageUrl, this.date, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: height * 0.22,
                      width: double.infinity,
                      fadeInDuration: Duration(milliseconds: 150),
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: height * 0.23,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ]),
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
                      placeholder: (context, val) => const LoadingWidget(),
                    )
                  : SizedBox(
                      height: height * 0.23,
                      width: double.infinity,
                      child: const Icon(
                        Icons.no_photography_rounded,
                        size: 50,
                      ),
                    ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.withOpacity(0.2),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 12,
                          height: 3,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
