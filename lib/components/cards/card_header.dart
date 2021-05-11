import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardHeader extends StatelessWidget {
  final String imageUrl;
  final double height;
  final bool applyBlur;

  CardHeader({this.imageUrl, this.height, this.applyBlur = false});

  final Widget _loadingWidget = Container(
    color: Colors.black26,
    child: Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: imageUrl == null
          ? _loadingWidget
          : Container(
              height: height,
              width: double.infinity,
              color: Theme.of(context).disabledColor,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress != null) return _loadingWidget;
                  if (applyBlur)
                    return ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: child,
                    );
                  return child;
                },
                errorBuilder: (context, object, stacktrace) => Center(
                  child: FaIcon(
                    FontAwesomeIcons.hospital,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),
            ),
    );
  }
}
