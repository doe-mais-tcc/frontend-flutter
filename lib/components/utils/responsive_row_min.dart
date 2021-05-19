import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

responsiveRowMin({
  MainAxisResponsiveRowAlignment mainAxisAlignment,
  CrossAxisResponsiveRowAlignment crossAxisAlignment,
  double mainAxisSpacing,
  double crossAxisSpacing,
  List<Widget> children,
  ColumnWidth columnWidth,
  double height,
}) {
  return ResponsiveRow(
    totalColumn: 12,
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
