import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class MainCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isBigCard;
  final Function onTap;
  const MainCardWidget({
    Key key,
    this.imageUrl,
    this.onTap,
    this.title,
    this.isBigCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        width: double.infinity,
        height: isBigCard ? 85 : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 350),
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: isBigCard ? 60 : 40,
                  width: isBigCard ? 85 : 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      alignment: Alignment.center,
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
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
                placeholder: (context, val) => SizedBox(
                  height: isBigCard ? 60 : 30,
                  width: isBigCard ? 85 : 30,
                  child: Center(
                    child: const LoadingWidget(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isBigCard ? 15 : 12,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
