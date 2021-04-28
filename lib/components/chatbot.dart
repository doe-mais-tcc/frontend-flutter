import 'package:doe_mais/components/chat_bubble.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/services/chatbot_service.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final textController = TextEditingController();
  final List<Message> messages = [];

  void newMessage(String text) {
    if (text.isEmpty) return;
    setState(() => messages.add(Message(text: text)));
    textController.clear();

    ChatBotService.queryInput(text)
        .then((response) => setState(() => messages.addAll(response)))
        .onError((error, stackTrace) => setState(() => messages.add(
              Message(
                text:
                    'Não foi possível responder a sua pergunta, tente novamente mais tarde',
                isInput: false,
              ),
            )));
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
            itemBuilder: (context, index) => ChatBubble(
              text: messages[index].text,
              isInput: messages[index].isInput,
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Faça uma pergunta'),
                    controller: textController,
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
