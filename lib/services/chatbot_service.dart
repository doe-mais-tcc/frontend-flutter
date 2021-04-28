import 'package:flutter_dialogflow_v2/flutter_dialogflow_v2.dart';
import 'package:doe_mais/models/message.dart' as msg;

class ChatBotService {
  static Future<List<msg.Message>> queryInput(String query) async {
    var authGoogle =
        await AuthGoogle(fileJson: 'assets/files/chatbot_service.json').build();
    var dialogflow = Dialogflow(authGoogle: authGoogle);
    var response = await dialogflow
        .detectIntentFromText(query, Language.portugueseBrazilian)
        .timeout(Duration(seconds: 3));

    List<msg.Message> output = [];
    for (Text message in response.queryResult.fulfillmentMessages)
      output.add(msg.Message(
        text: message.text[0],
        isInput: false,
      ));

    return output;
  }
}
