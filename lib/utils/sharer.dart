import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/score_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart' as mobile;
import 'package:flutter/foundation.dart' show kIsWeb;

enum SocialMedia { Facebook, Twitter, Whatsapp, Other }

class Sharer {
  static const String authority = 'doemais-924bf.web.app';

  static void share(SocialMedia socialMedia, Campanha campanha,
      [BuildContext context]) {
    switch (socialMedia) {
      case SocialMedia.Facebook:
        shareOnFacebook(campanha);
        break;
      case SocialMedia.Twitter:
        shareOnTwitter(campanha);
        break;
      case SocialMedia.Whatsapp:
        shareOnWhatsapp(campanha);
        break;
      case SocialMedia.Other:
        shareOther(campanha, context);
        break;
    }
    ScoreManager.addScore(3);
  }

  static void shareOnFacebook(Campanha campanha) async {
    var uri = Uri.https(
      'www.facebook.com',
      'sharer/sharer.php',
      {
        'u': _getCampanhaUrl(campanha),
        'quote': campanha.descricao,
      },
    );
    var url = uri.toString();
    if (await canLaunch(url)) launch(url);
  }

  static void shareOnTwitter(Campanha campanha) async {
    var uri = Uri.https(
      'www.twitter.com',
      'share',
      {
        'url': _getCampanhaUrl(campanha),
        'text': campanha.descricao,
      },
    );
    var url = uri.toString();
    if (await canLaunch(url)) launch(url);
  }

  static void shareOnWhatsapp(Campanha campanha) async {
    var uri = Uri.https(
      'wa.me',
      '',
      {
        'text': campanha.descricao + '\n' + _getCampanhaUrl(campanha),
      },
    );
    var url = uri.toString();
    if (await canLaunch(url)) launch(url);
  }

  static void shareOther(Campanha campanha, BuildContext context) async {
    String url = _getCampanhaUrl(campanha);

    if (kIsWeb) {
      Clipboard.setData(ClipboardData(text: url));
      messageBottomSheet(context: context, message: 'Link da campanha copiado');
    } else
      mobile.Share.share(campanha.descricao + '\n' + url);
  }

  static String _getCampanhaUrl(Campanha campanha) {
    var uri = Uri.https(
      authority,
      '#/campanhas/campanha',
      {'id': Campanha.uriEncode(campanha)},
    );
    return uri.toString();
  }
}
