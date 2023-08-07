import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/services/firebase_manager.dart';
import 'package:chat_app/views/get_user_detail_screen/get_user_detail_screen.dart';
import 'package:chat_app/views/home_page/home_screen_widget.dart';
import 'package:chat_app/views/on_boarding_screen/on_boarding_screen_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvier>(
            create: (context) => AuthenticationProvier()),
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider())
      ],
      child: MaterialApp(
          theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              primarySwatch: Colors.deepPurple),
          home: const SafeArea(child: AuthenticationWrapper())),
    ),
  );
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseManager.firebaseAuth.currentUser;

    if (user != null) {
      // User is authenticated, navigate to chat screen
      return const HomePageScreenWidget();
    } else {
      // User is not authenticated, navigate to login or registration
      return const OnBoardingScreenWidget();
    }
  }
}
