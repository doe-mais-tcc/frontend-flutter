import 'dart:io' as io;
import 'dart:math' show Random;
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:doe_mais/models/message.dart' as msg;

class ChatBotService {
  static const String path = 'assets/files/chatbot_credentials.json';

  static DialogFlowtter _df;
  static Future<DialogFlowtter> get _dialogFlowtter async {
    if (_df == null) {
      if (await io.File(path).exists()) {
        _df = await DialogFlowtter.fromFile(
          path: path,
          sessionId: Random().toString(),
        );
      } else {
        print('[CHATBOT ERROR] chatbot credentials not found');
        throw Exception();
      }
    }
    return _df;
  }

  static Future<List<msg.Message>> queryInput(String query) async {
    var queryInput =
        QueryInput(text: TextInput(text: query, languageCode: 'pt-Br'));

    var dialogFlowtter = await _dialogFlowtter;
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
}
