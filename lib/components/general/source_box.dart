import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SourceBox extends StatelessWidget {
  final String sourceLink;
  SourceBox({@required this.sourceLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
        ),
      ),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(sourceLink)) launch(sourceLink);
        },
        child: RichText(
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
          text: TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 12),
            text: 'Fonte: $sourceLink',
          ),
        ),
      ),
    );
  }
}
