import 'package:chat_app/services/firebase_manager.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthenticationProvier extends ChangeNotifier {
  List<ChatUser> users = [];
  String currentUserUid = "";

  Future<bool> fabLoginOnPressed(String number, BuildContext context) async {
    bool validNumber =
        await FirebaseManager.verifyUserPhoneNumber(number, context);
    return validNumber;
  }

  Future<bool> btnOnTabVerifyOtp(String otp, BuildContext context) async {
    bool isValidOtp = await FirebaseManager.verifyOtp(otp, context);
    return isValidOtp;
  }

  Future<bool> storeDataOnfirebase(String name, BuildContext context) async {
    bool isDataStored =
        await FirebaseManager.storeUserDataOnFirebase(userName: name);
    return isDataStored;
  }

  Future<void> loadUserData() async {
    print("Loading Function From Provier Start");
    currentUserUid = FirebaseManager.currentUserUid;
    FirebaseManager.getDataFromDatabase(collectionName: "users")
        .snapshots()
        .listen((event) {
      users.clear();
      for (final doc in event.docs) {
        print("Data : ${doc.data()}");
        if (!doc.data().toString().contains(currentUserUid)) {
          print("This Is Inside of IF Statement ");
          print(doc.data());
          users.add(ChatUser.fromJosn(doc.data() as Map<String, dynamic>));
        }
      }
      notifyListeners();
    });
  }
}
