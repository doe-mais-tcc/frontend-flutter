import 'dart:convert';
import 'dart:math' show Random;
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:doe_mais/models/message.dart' as msg;
import 'package:flutter/services.dart' show rootBundle;

class ChatBotService {
  static const String json = '''{
  type: service_account,
  project_id: doemais-924bf,
  private_key_id: 9c170e9508be37b14a4d0757984207184564a392,
  private_key: -----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDNOt1luQDSM8sy\nQ8NqVDUmLMEgi2UbxWFn/F+CvXgvBUeAr6FX8vh0IEbm9Jq4Zxh4Sf2j+gpqox3I\napoTCE4Xq5XKb9cRW8l1DQgv+kiQUdLdtq0RBt5lRYYN8Cp9/W/93BegzESNzIaH\nNdSukhtJ+EVw6pvHMlA5VY1MD9pkOfxZiWKvR9rVZrz14jlcr2T8/DeO3wVTjQtB\nHTgQ/hbSaojWJPjpOw5LmVo8t8E6DBH7OirY2YC5U+wpRlC+qrb3nKOvsRNe0OeL\n2JisBt6cP0kCGxgL4c5pCBLr+WUVB/ax827wsMznBKhaE2afzaQjvT9CF5UYEBM9\nEg5LLBV7AgMBAAECggEAIYxlAwsThx5qsdb28QDpRp9xRe8o148pUEommM99Kn6R\nRN2GS+4OzvjfGO5VA8jtQe33yvWFp2SZFUPWgj73eRIWTzx/ao8tEaJ65fuNdMi+\nEM/wXu9XAooIvcA2n1gtwFCurMfyJZXl9eCxrtnOdoXhtXF8hpBYdzmKJVbAFhBD\nj0gYeR3OPuoYP5RVyQVhC7LkCTSMe7hMxT/0CMcXjlcF4FRNdD2/6LQD9I4fUITs\nu1IAYU2JlR80oFs+WH85IXxiYfhZejeG+bRlq4CI3Jr5IaU/hWxQGzehFETn9/aT\noDqFgoyc5Ub+n7f2duIiJqcHBrqt59uNCroWLL/RIQKBgQDtGFGxlnmmztej8kM+\nRdJ5AKI7eEFszpGHIKEicWfnjh6rke4GliAJAjWtib1lhWFnWEUy0DGaPVXpeluM\njK/f4MT2VVgzqGX1JAh9sLtAt5i5hZSsa0Y9W72qDVTnDyf7KlVyDj5OvUsHOkxl\n/TIYXN484NHt8MDzw3dcsc0KIQKBgQDdmBphpm/3ITsEL0z0IpR304XkRRZE6doa\nHafZ0YzA9RFdu+WH3BVhsmvZ5XrdegM6/k0VfXbxyo4JYnMUTN1v8yheWUxUbyPv\nk4eGWhrrmmDc1p+J9oh4GpxmroI8ZGbaOkRNE8f+UKFRV8JcwNhuh4wBwKa/Fpxk\ne8eatPOEGwKBgFM7qVo9qCFOFdfBMagH3PaLqWhVNCqdbetRIiA0TbS1aMD0buoz\nA7YF55AvfaTJKUOdclV/TxqFk8ZuJPt3XDqs7phHp7oi0QA5ER4G0AXNLjla0rGg\nyzy5GyE6ouampHOBDhQHOgpsW42DAtT/CPoSiBY5Gpl8XlB0+084P/HhAoGADi8l\nSSjhM91xrKPmdh4ciMsGYAU4FrMtXcyWKPAr5VIKiYh0eczRpY5JLwpsYe7kdAtB\nHeYJDhMcImel3B/LcNYMuHVY2HLAxx4XZ7cuz/PyzVADqE4akC2L41q6RWlb2A4w\nvwpMG/BHUzCd5VgGwpR0lswhIEwvOJNfxHxetg8CgYEAq1dk7RLiKxbmFIS/qQNX\noCgty28WxvFdyXImZYfJXaDT9B6c4tiDJcXko1mvsUutwYh9CNQ8oFArlo7TC4IX\nnAx8H8rgQIOhq838Ah8Sdic7RqFeOq8aRcoSDXK3laDKvZJGjtd/Xdt4QtroJ1oL\n6tBCEDkKgQ5o26s5POVGerE=\n-----END PRIVATE KEY-----\n,
  client_email: chatbot@doemais-924bf.iam.gserviceaccount.com,
  client_id: 104321642899663849346,
  auth_uri: https://accounts.google.com/o/oauth2/auth,
  token_uri: https://oauth2.googleapis.com/token,
  auth_provider_x509_cert_url: https://www.googleapis.com/oauth2/v1/certs,
  client_x509_cert_url: https://www.googleapis.com/robot/v1/metadata/x509/chatbot%40doemais-924bf.iam.gserviceaccount.com
}
''';
  static const String _path = 'assets/files/chatbot_credentials.json';
  Map<String, dynamic> _chatbotCredentials;

  final String _sessionId;
  ChatBotService() : this._sessionId = Random().toString();

  Future<List<msg.Message>> queryInput(String query) async {
    var queryInput =
        QueryInput(text: TextInput(text: query, languageCode: 'pt-Br'));

    var dialogFlowtter = await _getDialogFlowtter().onError(
      (error, stackTrace) {
        print('[CHATBOT ERROR] $error: $stackTrace');
        throw error;
      },
    );

    var response =
        await dialogFlowtter.detectIntent(queryInput: queryInput).onError(
      (error, stackTrace) {
        print('[CHATBOT ERROR] $error: $stackTrace');
        throw error;
      },
    ).timeout(
      Duration(minutes: 1),
      onTimeout: () {
        print('[TIMEOUT] chatbot hit timeout');
        return null;
      },
    );

    List<msg.Message> output = [];
    for (var message in response.queryResult.fulfillmentMessages)
      output.add(msg.Message(
        text: message.text.text[0],
        isSender: false,
      ));

    return output;
  }

  Future<DialogFlowtter> _getDialogFlowtter() async {
    if (_chatbotCredentials == null) {
      String fileText = await rootBundle.loadString(_path);
      _chatbotCredentials = jsonDecode(fileText);
    }

    return DialogFlowtter.fromJson(_chatbotCredentials, sessionId: _sessionId);
  }
}
