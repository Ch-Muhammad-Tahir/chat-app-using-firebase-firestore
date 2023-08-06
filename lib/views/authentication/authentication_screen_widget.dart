import 'dart:math';

import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/utils/app_assets.dart';
import 'package:chat_app/utils/app_strings.dart';
import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/utils/media_query.dart';
import 'package:chat_app/views/authentication/otp_verify_screen.dart';
import 'package:chat_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

class OtpAuthenticationScreenWidget extends StatelessWidget {
  late String phoneNumber;
  OtpAuthenticationScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onTabFAB(context);
          },
          child: const Icon(
            Icons.arrow_right_alt_rounded,
            size: 35,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(children: [
            Image.asset(
              AppAssets.loginIcon1,
              height: GetScreenSize.getScreenHeight(context) * 0.35,
              width: GetScreenSize.getScreenWidth(context) * 0.35,
            ),
            Text(
              AppCommonStrings.loginSceenText,
              style: TextStyle(
                  fontSize: GetScreenSize.getScreenWidth(context) * 0.06),
            ),
            const CustomSizedBox(
              height: 20,
            ),
            IntlPhoneField(
              decoration: const InputDecoration(
                  //labelText: 'Phone Number',
                  ),
              initialValue: "+92",
              autofocus: false,
              //dropdownIcon: Icon(Icons.arrow_drop_down_circle),
              dropdownIconPosition: IconPosition.trailing,
              onChanged: (phone) {
                phoneNumber = phone.completeNumber;
              },
            )
          ]),
        ),
      ),
    );
  }

  void onTabFAB(BuildContext context) {
    Provider.of<AuthenticationProvier>(context, listen: false)
        .fabLoginOnPressed(phoneNumber, context)
        .then((isVaid) {
      print("Number $isVaid");
      if (isVaid) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OTPVerifyScreenWidget()));
      } else {
        AppCommonFunctions.showToast("InValid Number", context);
      }
    });
  }
}
