import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SourceBox extends StatelessWidget {
  final String sourceLink;
  SourceBox({@required this.sourceLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
        ),
      ),
      child: TextButton(
        onPressed: () async {
          if (await canLaunch(sourceLink)) launch(sourceLink);
        },
        child: RichText(
          maxLines: 1,
          softWrap: true,
          textWidthBasis: TextWidthBasis.longestLine,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 10),
            text: 'Fonte: ',
            children: [TextSpan(text: '$sourceLink')],
          ),
        ),
      ),
    );
  }
}
