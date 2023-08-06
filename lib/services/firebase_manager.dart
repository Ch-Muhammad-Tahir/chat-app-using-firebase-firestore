import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/common_functions.dart';

class FirebaseManager {
  static late String userPhoneNumber;
  static late String verficationID;
  static String currentUserUid = "";
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Future<bool> verifyUserPhoneNumber(
      String number, BuildContext context) async {
    late bool isValidNumber = false;
    print(number);
    await firebaseAuth
        .verifyPhoneNumber(
            phoneNumber: number,
            verificationCompleted: (_) {},
            verificationFailed: (e) {
              AppCommonFunctions.showToast("Verification Failed", context);
            },
            codeSent: (String verificationID, int? token) {
              verficationID = verificationID;
            },
            codeAutoRetrievalTimeout: (e) {})
        .then((value) => isValidNumber = true);
    print("Valur of $isValidNumber");
    return isValidNumber;
  }

  static Future<bool> verifyOtp(String otp, BuildContext context) async {
    var credential = PhoneAuthProvider.credential(
        verificationId: verficationID, smsCode: otp);
    try {
      await firebaseAuth.signInWithCredential(credential);
      AppCommonFunctions.showToast("OTP varified", context);
      if (firebaseAuth.currentUser != null) {
        currentUserUid = firebaseAuth.currentUser!.uid;
        userPhoneNumber = firebaseAuth.currentUser!.phoneNumber!;
        return true;
      }
      print(firebaseAuth.currentUser!.uid);
    } catch (e) {
      AppCommonFunctions.showToast("InValid OTP", context);
    }
    return false;
  }

  static Future<bool> storeUserDataOnFirebase({
    required String userName,
  }) async {
    var collection = FirebaseFirestore.instance.collection("users");
    await collection.doc(currentUserUid).set({
      "userName": userName,
      "uId": currentUserUid,
      "phoneNumber": userPhoneNumber
    });
    if (collection.doc(currentUserUid).id == currentUserUid) {
      return true;
    } else {
      return false;
    }
  }

  static CollectionReference getDataFromDatabase(
      {required String collectionName}) {
    print("getDataFromDatabase is Calling ");
    CollectionReference dBCollectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    return dBCollectionReference;
  }

  static Future<void> sendMessage(
      {required String message,
      required String reciverId,
      required String chatRoomId}) async {
    var chatRoomCollection = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages");
    chatRoomCollection.add({
      "senderUid": currentUserUid,
      "reciverUid": reciverId,
      "messageText": message,
      "timeStamp": FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join("_");

    return firestore
        .collection("chats")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }

  static CollectionReference getChatMessages({required String chatRoomId}) {
    CollectionReference messagesCollectionReference = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages");
    return messagesCollectionReference;
  }
}
