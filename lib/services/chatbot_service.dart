import 'dart:convert';
import 'dart:math' show Random;
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:doe_mais/models/message.dart' as msg;
import 'package:flutter/services.dart' show rootBundle;

class ChatBotService {
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
