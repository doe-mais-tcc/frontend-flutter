import 'package:doe_mais/components/general/custom_chat_bubble.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/utils/chatbot_list_manager.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  final listKey = GlobalKey<AnimatedListState>();

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final textController = TextEditingController();
  final textFieldFocus = FocusNode();
  final List<Message> messages = [];
  ChatbotListManager chatbotListManager;

  void initialize() {
    chatbotListManager = ChatbotListManager(
      messages: messages,
      listKey: widget.listKey,
    );
    chatbotListManager.welcomeMessage();
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;

    textController.clear();
    textFieldFocus.requestFocus();
    chatbotListManager.newMessage(text);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, initialize);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: AnimatedList(
            key: widget.listKey,
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemBuilder: (context, index, animation) {
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
