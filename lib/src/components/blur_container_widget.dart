import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlurContainerWidget extends StatelessWidget {
  final String svgPath;
  final String title;
  final Function onTap;
  const BlurContainerWidget({Key key, this.svgPath, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(svgPath),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
