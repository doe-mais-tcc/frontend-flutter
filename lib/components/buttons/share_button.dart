import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/sharer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareButton extends StatelessWidget {
  static const Color _facebookColor = Color(0xff3b5998);
  static const Color _twitterColor = Color(0xff1da1f2);
  static const Color _whatsappColor = Color(0xff25d366);

  final SocialMedia socialMedia;
  final Campanha campanha;
  ShareButton({@required this.socialMedia, @required this.campanha});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: () {
        IconData icon;
        Color color;
        switch (socialMedia) {
          case SocialMedia.Facebook:
            icon = FontAwesomeIcons.facebookF;
            color = _facebookColor;
            break;
          case SocialMedia.Twitter:
            icon = FontAwesomeIcons.twitter;
            color = _twitterColor;
            break;
          case SocialMedia.Whatsapp:
            icon = FontAwesomeIcons.whatsapp;
            color = _whatsappColor;
            break;
          case SocialMedia.Other:
            icon = Icons.more_horiz;
            color = Theme.of(context).disabledColor;
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360),
            color: color,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 20,
          ),
        );
      }(),
      padding: const EdgeInsets.all(0),
      onPressed: () => Sharer.share(socialMedia, campanha),
      color: Colors.white,
    );
  }
}
