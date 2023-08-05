import 'package:chat_app/utils/app_assets.dart';
import 'package:chat_app/utils/app_buttons_text.dart';
import 'package:chat_app/utils/app_strings.dart';
import 'package:chat_app/utils/media_query.dart';
import 'package:chat_app/views/authentication/authentication_screen_widget.dart';
import 'package:chat_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class OnBoardingScreenWidget extends StatelessWidget {
  final TextStyle titleStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  const OnBoardingScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            AppAssets.onBoadringPersonsChatView,
            width: GetScreenSize.getScreenWidth(context),
            height: GetScreenSize.getScreenHeight(context) * 0.6,
          ),
          CustomSizedBox(
            height: GetScreenSize.getScreenHeight(context) * 0.04,
          ),
          CustomSizedBox(
              width: GetScreenSize.getScreenWidth(context) * 0.8,
              child: Text(
                AppCommonStrings.onBoardigScrrenTitle,
                style: titleStyle,
                textAlign: TextAlign.center,
              )),
          CustomSizedBox(
            height: GetScreenSize.getScreenHeight(context) * 0.005,
          ),
          Text(
            AppCommonStrings.onBoardigScrrenSubTitle,
          ),
          CustomSizedBox(
            height: GetScreenSize.getScreenHeight(context) * 0.03,
          ),
          CustomButton(
            color: Colors.deepPurple.shade700,
            height: GetScreenSize.getScreenHeight(context) * 0.06,
            text: AppButtonText.onBoaringBtnGetStarted,
            width: GetScreenSize.getScreenHeight(context) * 0.35,
            onTab: () {
              onTapbtnGetStarted(context);
            },
          )
        ],
      ),
    );
  }

  void onTapbtnGetStarted(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                OtpAuthenticationScreenWidget()));
  }
}
