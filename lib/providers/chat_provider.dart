import 'package:chat_app/models/chat.dart';
import 'package:chat_app/services/firebase_manager.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> messages = [];
  void sendMessageOnServer(String message, String receiverUid) async {
    List<String> ids = [FirebaseManager.currentUserUid, receiverUid];
    ids.sort();
    String chatRoomId = ids.join('_');
    await FirebaseManager.sendMessage(
        message: message, reciverId: receiverUid, chatRoomId: chatRoomId);
    notifyListeners();
  }

  void getMessagesFromServer(String receiverUid) {
    print("getMessagesFromServer Called");
    List<String> ids = [FirebaseManager.currentUserUid, receiverUid];
    ids.sort();
    String chatRoomId = ids.join('_');
    FirebaseManager.getChatMessages(chatRoomId: chatRoomId)
        .orderBy('timeStamp', descending: false)
        .snapshots()
        .listen((messages) {
      this.messages.clear();
      for (final msg in messages.docs) {
        print("Messages: ${msg.data()}");
        this.messages.add(Message.fromJson(msg.data() as Map<String, dynamic>));
      }

      notifyListeners();
    });
  }
}
