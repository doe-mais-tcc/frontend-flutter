import 'dart:math' show Random;
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:doe_mais/models/message.dart' as msg;

class ChatBotService {
  static const String path = 'assets/files/chatbot_credentials.json';

  static DialogFlowtter _df;
  static Future<DialogFlowtter> get _dialogFlowtter async {
    if (_df == null) {
      _df = await DialogFlowtter.fromFile(
        path: path,
        sessionId: Random().toString(),
      );
    }
    return _df;
  }

  static Future<List<msg.Message>> queryInput(String query) async {
    var queryInput =
        QueryInput(text: TextInput(text: query, languageCode: 'pt-Br'));

    var dialogFlowtter = await _dialogFlowtter;
    var response = await dialogFlowtter.detectIntent(queryInput: queryInput);

    List<msg.Message> output = [];
    for (var message in response.queryResult.fulfillmentMessages)
      output.add(msg.Message(
        text: message.text.text[0],
        isInput: false,
      ));

    return output;
  }
}
