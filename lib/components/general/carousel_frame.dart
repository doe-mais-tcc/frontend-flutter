import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final Widget child;
  final CarouselController carouselController;
  final double height;
  CustomCarousel({
    @required this.child,
    @required this.height,
    @required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).canvasColor;
    final transparent = Colors.white.withAlpha(0);
    return Column(
      children: [
        Stack(
          children: [
            child,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [background, transparent],
                      ),
                    ),
                    child: Icon(Icons.chevron_left),
                  ),
                  onTap: () => carouselController.previousPage(),
                ),
                InkWell(
                  child: Container(
                    height: height,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [transparent, background],
                      ),
                    ),
                    child: Icon(Icons.chevron_right),
                  ),
                  onTap: () => carouselController.nextPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
