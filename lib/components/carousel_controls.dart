import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class CarouselControls extends StatelessWidget {
  final InfiniteCarousel infiniteCarousel;
  final double height;
  CarouselControls({
    @required this.infiniteCarousel,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () =>
                (infiniteCarousel.controller as InfiniteScrollController)
                    ?.previousItem(),
          ),
          Flexible(child: infiniteCarousel),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              size: 30,
            ),
            onPressed: () =>
                (infiniteCarousel.controller as InfiniteScrollController)
                    ?.nextItem(),
          ),
        ],
      ),
    );
  }
}
