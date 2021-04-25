import 'package:flutter_dialogflow_v2/flutter_dialogflow_v2.dart';
import 'package:doe_mais/models/message.dart' as msg;

class ChatBotService {
  static Future<msg.Message> queryInput(String query) async {
    var authGoogle =
        await AuthGoogle(fileJson: 'assets/files/chatbot_service.json').build();
    var dialogflow = Dialogflow(authGoogle: authGoogle, sessionId: '123456');
    var response = await dialogflow.detectIntentFromText(
        query, Language.portugueseBrazilian);

    String output = response == null
        ? 'Não foi possível verificar a solicitação'
        : (response.queryResult.fulfillmentMessages[0] as Text).text[0];

    return msg.Message(text: output, isInput: false);
  }
}
