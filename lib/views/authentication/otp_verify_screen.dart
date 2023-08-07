import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/utils/app_assets.dart';
import 'package:chat_app/utils/app_strings.dart';
import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../utils/app_buttons_text.dart';
import '../../utils/media_query.dart';
import '../get_user_detail_screen/get_user_detail_screen.dart';

class OTPVerifyScreenWidget extends StatelessWidget {
  late String getOtp;

  OTPVerifyScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Image.asset(
          AppAssets.loginIcon3,
          height: GetScreenSize.getScreenHeight(context) * 0.35,
          width: GetScreenSize.getScreenWidth(context) * 0.35,
        ),
        Text(
          AppCommonStrings.otpVerificatoin,
          style: TextStyle(
            fontSize: GetScreenSize.getScreenWidth(context) * 0.09,
          ),
        ),
        Text(AppCommonStrings.enterOTPCode),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: OTPTextField(
            //controller: otpController,
            length: 6,
            width: MediaQuery.of(context).size.width * 0.05,
            textFieldAlignment: MainAxisAlignment.center,
            spaceBetween: 6,
            fieldWidth: 30,
            fieldStyle: FieldStyle.underline,
            outlineBorderRadius: 15,
            // obscureText: true,
            style: const TextStyle(fontSize: 17),
            onCompleted: (pin) {
              getOtp = pin;
            },
          ),
        ),
        CustomButton(
          color: Colors.deepPurple.shade700,
          height: GetScreenSize.getScreenHeight(context) * 0.06,
          text: AppButtonText.verifyOtp,
          width: GetScreenSize.getScreenHeight(context) * 0.35,
          onTab: () {
            Provider.of<AuthenticationProvier>(context, listen: false)
                .btnOnTabVerifyOtp(getOtp, context)
                .then((isValidOtp) {
              if (isValidOtp) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            GetUserDetailScreen()));
              } else {
                AppCommonFunctions.showToast(
                    AppCommonStrings.invalidOTP, context);
              }
            });
          },
        )
      ]),
    );
  }
}
