import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/sharer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareButton extends StatelessWidget {
  static const Color _facebookColor = Color(0xff3b5998);
  static const Color _twitterColor = Color(0xff1da1f2);

  final SocialMedia socialMedia;
  final Campanha campanha;
  ShareButton({@required this.socialMedia, @required this.campanha});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: () {
        switch (socialMedia) {
          case SocialMedia.Facebook:
            return FaIcon(
              FontAwesomeIcons.facebook,
              color: _facebookColor,
            );
          case SocialMedia.Twitter:
            return FaIcon(
              FontAwesomeIcons.twitter,
              color: _twitterColor,
            );
        }
      }(),
      iconSize: 30,
      padding: const EdgeInsets.all(0),
      onPressed: () => Sharer.share(socialMedia, campanha),
    );
  }
}
