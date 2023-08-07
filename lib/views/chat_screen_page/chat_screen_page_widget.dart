import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/services/firebase_manager.dart';
import 'package:chat_app/views/chat_screen_page/chat_screen_widgets/custom_app_bar_tile.dart';
import 'package:chat_app/views/chat_screen_page/chat_screen_widgets/message_bubble_tile_view.dart';
import 'package:chat_app/views/chat_screen_page/chat_screen_widgets/write_message_textfield.dart';
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
    Provider.of<ChatProvider>(context, listen: false)
        .getStatusFromDatabase(widget.reciverUser.uId);
    Provider.of<ChatProvider>(context, listen: false)
        .getMessagesFromServer(widget.reciverUser.uId);
    super.initState();
  }

  TextEditingController tfMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: CustomAppBarTile(
            onTab: () {
              Navigator.pop(context);
            },
            receiverUser: widget.reciverUser,
          ),
        ),
      ),
      body: Stack(children: [
        Consumer<ChatProvider>(builder: (context, provider, child) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                bool isSender = provider.messages[index].senderUid ==
                    FirebaseManager.currentUserUid;
                return ChatBubble(
                    isCurrentUser: isSender,
                    text: provider.messages[index].messageText);
              },
              itemCount: provider.messages.length);
        }),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Expanded(
                child: WriteMessageTextField(
                    controller: tfMessageController,
                    onSendTab: () {
                      tabOnSend();
                    }),
              ),
            ],
          ),
        )
      ]),
    );
  }

  void tabOnSend() {
    String message = tfMessageController.text.trim();
    if (message.isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false)
          .sendMessageOnServer(message, widget.reciverUser.uId);

      tfMessageController.clear();
    }
    Provider.of<ChatProvider>(context, listen: false)
        .messages
        .forEach((element) {});
  }
}
