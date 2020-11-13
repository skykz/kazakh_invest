import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class ViewFullScreen extends StatelessWidget {
  final String imageUrl;
  const ViewFullScreen({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 350),
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => const SizedBox(
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
          placeholder: (context, val) =>
              const SizedBox(height: 30, width: 30, child: LoadingWidget()),
        ),
      ],
    );
  }
}
