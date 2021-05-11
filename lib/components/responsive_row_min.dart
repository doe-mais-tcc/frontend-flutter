import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class ResponsiveRowMin extends StatelessWidget {
  final MainAxisResponsiveRowAlignment mainAxisAlignment;
  final CrossAxisResponsiveRowAlignment crossAxisAlignment;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<Widget> children;
  final ColumnWidth columnWidth;
  final double height;
  ResponsiveRowMin({
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.children,
    this.columnWidth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveRow(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSpacing: mainAxisSpacing ?? 0,
      crossAxisSpacing: crossAxisSpacing ?? 0,
      children: children
          .map((e) => ResponsiveColumn(
                child: height == null
                    ? e
                    : SizedBox(
                        height: height,
                        child: e,
                      ),
                width: columnWidth,
              ))
          .toList(),
    );
  }
}
