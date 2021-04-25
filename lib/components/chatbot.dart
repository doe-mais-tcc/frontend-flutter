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

  void newMessage() {
    String text = textController.text;
    if (text.isEmpty) return;
    setState(() => messages.add(Message(text: text)));
    textController.clear();

    ChatBotService.queryInput(text)
        .then((output) => setState(() => messages.add(output)));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 500, minWidth: 800),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) => ChatBubble(
              text: messages[index].text,
              isInput: messages[index].isInput,
            ),
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: textController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: newMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
