import 'dart:math';

import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/views/authentication/otp_verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

class OtpAuthenticationScreenWidget extends StatelessWidget {
  late String phoneNumber;
  OtpAuthenticationScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AuthenticationProvier>(context, listen: false)
              .fabLoginOnPressed(phoneNumber, context)
              .then((isVaid) {
            print("Number $isVaid");
            if (isVaid) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OTPVerifyScreenWidget()));
            } else {
              AppCommonFunctions.showToast("InValid Number", context);
            }
          });
        },
        child: const Icon(
          Icons.arrow_right_alt_rounded,
          size: 35,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
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
    );
  }
}
