import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/services/chatbot_service.dart';
import 'package:flutter/cupertino.dart';

class ChatbotListManager {
  static const String errorMessage =
      'Desculpe, estamos tendo problemas em responder a sua pergunta, tente novamente mais tarde';
  final List<Message> messages;
  final GlobalKey<AnimatedListState> listKey;
  ChatbotListManager({@required this.messages, @required this.listKey});

  void newMessage(String text) {
    var loadingMessage = Message(isSender: false);
    _addToList(messages.length, [
      Message(text: text),
      loadingMessage,
    ]);

    _queryMessage(text, loadingMessage);
  }

  void welcomeMessage() {
    var loadingMessage = Message(isSender: false);
    _addToList(0, [loadingMessage]);
    _queryMessage('oi', loadingMessage);
  }

  void _addToList(int index, List<Message> elements) {
    messages.insertAll(index, elements);
    for (int i = 0; i < elements.length; i++)
      listKey.currentState.insertItem(index++);
  }

  void _replaceMessage(Message replaced, List<Message> replacements) {
    int index = messages.lastIndexOf(replaced);

    messages.removeAt(index);
    _addToList(index, replacements);
    listKey.currentState.removeItem(index, (context, animation) => null);
  }

  void _queryMessage(String text, Message loadingMessage) async {
    var response = await ChatBotService.queryInput(text).onError(
      (error, stackTrace) {
        var message = Message(
          text: errorMessage,
          isSender: false,
        );
        _replaceMessage(loadingMessage, [message]);
        return;
      },
    );
    _replaceMessage(loadingMessage, response);
  }
}
