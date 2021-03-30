import 'package:url_launcher/url_launcher.dart';

class Sharer {
  static void shareOnFacebook(String rawUrl) {
    String convertedUrl = _facebookEncode(rawUrl);
    String url = 'https://www.facebook.com/sharer/sharer.php?u='
        '$convertedUrl'
        ';src=sdkpreparse';
    canLaunch(url).then(
      (value) => value
          ? launch(url)
          : throw Exception('Não foi possível compartilhar'),
    );
  }

  static String _facebookEncode(String url) {
    const List<String> specialChars = [
      ':',
      '/',
      '#',
      '?',
      '&',
      '@',
      '%',
      '+',
      '~',
      ';',
      '=',
      '\$',
      ','
    ];
    String output = url;
    for (var char in specialChars) {
      output.replaceAll(char, char.codeUnits[0].toRadixString(16));
    }
    return output;
  }
}
