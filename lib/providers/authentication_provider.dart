import 'dart:io';

import 'package:chat_app/services/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';

class AuthenticationProvier extends ChangeNotifier {
  List<ChatUser> users = [];
  String currentUserUid = "";
  File? pickedimg;

  Future<bool> fabLoginOnPressed(String number, BuildContext context) async {
    bool validNumber =
        await FirebaseManager.verifyUserPhoneNumber(number, context);
    return validNumber;
  }

  Future<bool> btnOnTabVerifyOtp(String otp, BuildContext context) async {
    bool isValidOtp = await FirebaseManager.verifyOtp(otp, context);
    return isValidOtp;
  }

  Future<bool> storeDataOnfirebase(
      String name, BuildContext context, File image) async {
    bool isDataStored = await FirebaseManager.storeUserDataOnFirebase(
        userName: name, image: image);
    return isDataStored;
  }

  Future<void> loadUserData() async {
    print("Loading Function From Provier Start");
    currentUserUid = FirebaseManager.firebaseAuth.currentUser!.uid;
    FirebaseManager.getDataFromDatabase(collectionName: "users")
        .snapshots()
        .listen((event) {
      users.clear();
      //print(event.docs.length);
      for (final doc in event.docs) {
        // print("Data : ${doc.data()}");

        //  print(currentUserUid);
        //print(doc["uId"]);
        if (doc["uId"] != currentUserUid)

        //if (!doc.data().toString().contains(currentUserUid.toString()))
        {
          //   print("This Is Inside of IF Statement ");
          // print(doc.data());
          users.add(ChatUser.fromJosn(doc.data() as Map<String, dynamic>));
        }
      }
      print("User Length : ${users.length}");
      notifyListeners();
    });
  }

  Future<File?> pickedImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      var file = File(image.path);
      pickedimg = file;
      notifyListeners();
      return file;
    }

    return null;
  }
}
