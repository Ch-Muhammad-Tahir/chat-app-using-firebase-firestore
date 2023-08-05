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

    // firebaseAuth.verifyPhoneNumber(
    //     phoneNumber: number,
    //     verificationCompleted: (_) {},
    //     verificationFailed: (e) {
    //       AppCommonFunctions.showToast(e.toString(), context);
    //     },
    //     codeSent: (String verificationID, int? token) {
    //       verficationID = verificationID;
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => OTPVerifyScreenWidget()));
    //     },
    //     codeAutoRetrievalTimeout: (e) {
    //       AppCommonFunctions.showToast("Time Out! OTP Exired!", context);
    //     });
  }

  Future<bool> btnOnTabVerifyOtp(String otp, BuildContext context) async {
    bool isValidOtp = await FirebaseManager.verifyOtp(otp, context);
    return isValidOtp;
    // var credential = PhoneAuthProvider.credential(
    //     verificationId: verficationID, smsCode: otp);
    // try {
    //   await firebaseAuth.signInWithCredential(credential);
    //   AppCommonFunctions.showToast("User Added", context);
    //   if (firebaseAuth.currentUser != null) {
    //     currentUserUid = firebaseAuth.currentUser!.uid;
    //     userPhoeNumber = firebaseAuth.currentUser!.phoneNumber!;
    //     return true;
    //   }

    //   print(firebaseAuth.currentUser!.uid);
    // } catch (e) {
    //   AppCommonFunctions.showToast("InValid OTP", context);
    // }
    // return false;
  }

  Future<bool> storeDataOnfirebase(String name, BuildContext context) async {
    bool isDataStored =
        await FirebaseManager.storeUserDataOnFirebase(userName: name);
    return isDataStored;
    // var collection = FirebaseFirestore.instance.collection("users");
    // await collection.doc(currentUserUid).set({
    //   "userName": name,
    //   "uId": currentUserUid,
    //   "phoneNumber": userPhoeNumber
    // });
    // if (collection.doc(currentUserUid).id == currentUserUid) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future<void> loadUserData() async {
    print("Loading Function From Provier Start");
    // print("getDataFromDatabase is Calling ");
    // CollectionReference dBCollectionReference =
    //     FirebaseFirestore.instance.collection("users");
    // await dBCollectionReference.
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

    // await dBCollectionReference
    //     .where("uId", isNotEqualTo: currentUserUid)
    //     .get()
    //     .then((snapshot) {
    //   users.clear();
    //   for (final doc in snapshot.docs) {
    //     //print(doc.data());
    //     users.add(ChatUser.fromJosn(doc.data() as Map<String, dynamic>));
    //   }
    //   users.forEach((element) {
    //     //print(element);
    //   });
    // });
    print("Hello World");
    for (var myUser in users) {
      print("User Name:${myUser.name}");
      print("User Number:${myUser.phoneNumber}");
      print("User ID:${myUser.uId}");
      print("----------------------------------------------");
    }

    //notifyListeners();
  }
}
