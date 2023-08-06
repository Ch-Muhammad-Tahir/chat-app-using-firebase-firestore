import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderUid = "";
  String receiverUid = "";
  String messageText = "";
  Timestamp? timeStamp;
  Message.fromJson(Map<String, dynamic> json) {
    if (json["senderUid"] is String || json["senderUid"] is int) {
      senderUid = json["senderUid"].toString();
    }
    if (json["reciverUid"] is String || json["reciverUid"] is int) {
      receiverUid = json["reciverUid"].toString();
    }
    if (json["messageText"] is String || json["messageText"] is int) {
      messageText = json["messageText"].toString();
    }
    if (json["timeStamp"] is Timestamp) {
      timeStamp = json["timeStamp"];
    }
  }
}
