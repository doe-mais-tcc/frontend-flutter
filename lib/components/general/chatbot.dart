import 'package:doe_mais/components/general/custom_chat_bubble.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/utils/chatbot_list_manager.dart';
import 'package:doe_mais/utils/score_manager.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final textController = TextEditingController();
  final textFieldFocus = FocusNode();
  final List<Message> messages = [];
  ChatbotListManager chatbotListManager;
  bool started = false;

  void sendMessage(String text) {
    if (text.isEmpty) return;
    if (!started) {
      ScoreManager.addScore(2);
      started = true;
    }

    textController.clear();
    textFieldFocus.requestFocus();

    chatbotListManager.newMessage(text);
  }

  void updateList(List<Message> newMessages, [Message replacement]) {
    if (replacement == null)
      setState(() => messages.addAll(newMessages));
    else
      setState(() {
        var index = messages.indexOf(replacement);
        messages.removeAt(index);
        messages.insertAll(index, newMessages);
      });
  }

  @override
  void initState() {
    chatbotListManager = ChatbotListManager(updateList);
    Future.delayed(Duration.zero).then(
      (value) => chatbotListManager.welcomeMessage(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              int i = messages.length - index - 1;
              return CustomChatBubble(messages[i]);
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
                    onSubmitted: sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () => sendMessage(textController.text),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
