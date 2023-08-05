import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/views/authentication/authentication_screen_widget.dart';
import 'package:chat_app/views/authentication/otp_verify_screen.dart';
import 'package:chat_app/views/home_page/home_screen_widget.dart';
import 'package:chat_app/views/on_boarding_screen/on_boarding_screen_widget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'views/get_user_detail_screen/get_user_detail_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationProvier>(
          create: (context) => AuthenticationProvier())
    ],
    child: MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SafeArea(child: OnBoardingScreenWidget()),
    ),
  ));
}