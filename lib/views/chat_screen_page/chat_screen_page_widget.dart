import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/services/firebase_manager.dart';
import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/views/chat_screen_page/chat_screen_widgets/message_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreenPageWidged extends StatefulWidget {
  final ChatUser reciverUser;
  const ChatScreenPageWidged({super.key, required this.reciverUser});

  @override
  State<ChatScreenPageWidged> createState() => _ChatScreenPageWidgedState();
}

class _ChatScreenPageWidgedState extends State<ChatScreenPageWidged> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatProvider>(context, listen: false)
        .getMessagesFromServer(widget.reciverUser.uId);
    super.initState();
  }

  TextEditingController tfMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("User Name"),
      ),
      body: Column(children: [
        Consumer<ChatProvider>(builder: (context, provider, child) {
          return Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              bool isSender = provider.messages[index].senderUid ==
                  FirebaseManager.currentUserUid;
              return Align(
                  alignment:
                      isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: ChatBubble(
                    isCurrentUser: isSender,
                    text: provider.messages[index].messageText,
                  ));
            },
            itemCount: provider.messages.length,
          ));
        }),
        TextField(
          controller: tfMessageController,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Type something....",
              suffix: IconButton(
                  onPressed: () {
                    String message = tfMessageController.text.trim();
                    if (message.isNotEmpty) {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendMessageOnServer(message, widget.reciverUser.uId);

                      tfMessageController.clear();
                    }
                    Provider.of<ChatProvider>(context, listen: false)
                        .messages
                        .forEach((element) {
                      print(element.messageText);
                    });
                  },
                  icon: const Icon(Icons.send_rounded))),
          minLines: 1,
          maxLines: 5,
        ),
      ]),
    );
  }
}
