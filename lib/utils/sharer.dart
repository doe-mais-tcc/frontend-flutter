import 'package:url_launcher/url_launcher.dart';

class Sharer {
  static void shareOnFacebook(String link, {String quote}) {
    String url = 'https://www.facebook.com/sharer/sharer.php?u=$link';
    if (quote != null) url += '&quote=$quote';
    launch(url).onError(
      (error, stackTrace) => throw Exception('Não foi possível compartilhar'),
    );
  }
}
