import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class NewsBigCardWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String date;
  const NewsBigCardWidget({Key key, this.title, this.imageUrl, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 350),
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.red,
                              BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) => Container(
                        height: 30,
                        width: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 25,
                          ),
                        ),
                      ),
                  placeholder: (context, val) => LoadingWidget()),
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
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 3,
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
