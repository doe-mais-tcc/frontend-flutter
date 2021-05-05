import 'package:doe_mais/models/campanha.dart';
import 'package:url_launcher/url_launcher.dart';

class Sharer {
  static const String authority = 'doemais-924bf.web.app';

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

  static String _getCampanhaUrl(Campanha campanha) {
    var uri = Uri.https(
      authority,
      'campanhas/campanha',
      {'id': Campanha.uriEncode(campanha)},
    );
    return uri.toString();
  }
}
