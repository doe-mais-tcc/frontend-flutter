import 'package:doe_mais/components/chat_bubble.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/services/chatbot_service.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final textFieldFocus = FocusNode();
  final textController = TextEditingController();
  final List<Widget> messages = [];

  void newMessage(String text) async {
    if (text.isEmpty) return;

    var messageIndex = messages.length;
    setState(() => messages.insertAll(messageIndex, [
          ChatBubble(Message(text: text)),
          ChatBubble.indicator(),
        ]));

    textController.clear();
    textFieldFocus.requestFocus();

    List<Message> response = await ChatBotService.queryInput(text).onError(
      (error, stackTrace) => [
        Message(
          text:
              'Não foi possível responder a sua pergunta, tente novamente mais tarde',
          isInput: false,
        )
      ],
    );
    setState(() {
      messages.removeAt(++messageIndex);
      messages.insertAll(messageIndex, response.map((e) => ChatBubble(e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 400),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => messages[index],
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
