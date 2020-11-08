import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class CardMainWhite extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double height;
  final double width;

  const CardMainWhite(
      {Key key, this.imageUrl, this.title, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 350),
            imageUrl: imageUrl,
            errorWidget: (context, url, error) => Container(
              height: 30,
              width: 30,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 25,
                  )),
            ),
            placeholder: (context, val) =>
                Container(height: 30, width: 30, child: LoadingWidget()),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
