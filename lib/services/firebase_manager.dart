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

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => OTPVerifyScreenWidget()));
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
    // await dBCollectionReference.snapshots().listen((event) {
    //   users.clear();
    //   for (final doc in event.docs) {
    //     if (!doc.data().toString().contains(currentUserUid)) {
    //       print(doc.data());
    //       users.add(ChatUser.fromJosn(doc.data() as Map<String, dynamic>));
    //     }
    //   }
  }
}
