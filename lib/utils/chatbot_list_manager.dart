import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/services/chatbot_service.dart';

class ChatbotListManager {
  static const String errorMessage =
      'Desculpe, estamos tendo problemas em responder a sua pergunta, tente novamente mais tarde';
  final chatbotService = ChatBotService();
  final Function(List<Message>, [Message]) updateList;

  ChatbotListManager(this.updateList);

  void newMessage(String text) async {
    var newMessage = Message(text: text);
    var loadingMessage = Message(isSender: false);

    updateList([newMessage, loadingMessage]);
    _queryMessage(text, loadingMessage);
  }

  void welcomeMessage() async {
    var loadingMessage = Message(isSender: false);

    updateList([loadingMessage]);
    _queryMessage('oi', loadingMessage);
  }

  void _queryMessage(String text, Message loadingMessage) async {
    var response = await chatbotService.queryInput(text).onError(
      (error, stackTrace) {
        return [
          Message(
            text: errorMessage,
            isSender: false,
          )
        ];
      },
    );
    updateList(response, loadingMessage);
  }
}
