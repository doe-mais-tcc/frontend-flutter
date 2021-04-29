import 'package:doe_mais/components/chat_bubble.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/services/chatbot_service.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatelessWidget {
  final listKey = GlobalKey<AnimatedListState>();
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final textFieldFocus = FocusNode();
  final loadingMessage = Message(isInput: false);
  final List<Message> messages = [];

  void newMessage(String text) {
    if (text.isEmpty) return;

    var loadingIndex = messages.length + 1;
    addToList(messages.length, [
      Message(text: text),
      loadingMessage,
    ]);

    textController.clear();
    textFieldFocus.requestFocus();

    ChatBotService.queryInput(text).then(
      (response) {
        messages.removeAt(loadingIndex);
        addToList(loadingIndex, response);
        listKey.currentState
            .removeItem(loadingIndex, (context, animation) => null);
      },
    ).onError(
      (error, stackTrace) {
        messages.removeAt(loadingIndex);
        addToList(loadingIndex, [
          Message(
            text:
                'Não foi possível responder a sua pergunta, tente novamente mais tarde',
            isInput: false,
          )
        ]);
        listKey.currentState
            .removeItem(loadingIndex, (context, animation) => null);
      },
    );
  }

  void addToList(int index, List<Message> elements) {
    messages.insertAll(index, elements);
    for (int i = 0; i < elements.length; i++)
      listKey.currentState.insertItem(index++);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: AnimatedList(
            key: listKey,
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            controller: scrollController,
            itemBuilder: (context, index, animation) {
              int i = messages.length - index - 1;
              return ChatBubble(messages[i]);
            },
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    autofocus: true,
                    controller: textController,
                    focusNode: textFieldFocus,
                    decoration: InputDecoration(hintText: 'Faça uma pergunta'),
                    onSubmitted: (text) => newMessage(text),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => newMessage(textController.text),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
