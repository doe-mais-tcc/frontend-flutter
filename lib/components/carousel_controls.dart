import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class CarouselControls extends StatelessWidget {
  final InfiniteScrollController controller;
  final InfiniteCarousel infiniteCarousel;
  CarouselControls({this.infiniteCarousel, this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          onPressed: () => controller.previousItem(),
        ),
        Flexible(
          child: infiniteCarousel,
        ),
        IconButton(
          icon: Icon(
            Icons.chevron_right,
            size: 30,
          ),
          onPressed: () => controller.nextItem(),
        ),
      ],
    );
  }
}
