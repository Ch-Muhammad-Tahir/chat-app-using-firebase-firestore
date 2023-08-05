import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/views/home_page/home_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';
import '../../utils/media_query.dart';
import '../../widgets/custom_button.dart';

class GetUserDetailScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  GetUserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.yellow,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Enter You Name"),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              color: Colors.deepPurple.shade700,
              height: GetScreenSize.getScreenHeight(context) * 0.06,
              text: "Next",
              width: GetScreenSize.getScreenHeight(context) * 0.35,
              onTab: () {
                String name = controller.text.trim();
                if (name.isNotEmpty) {
                  Provider.of<AuthenticationProvier>(context, listen: false)
                      .storeDataOnfirebase(name, context)
                      .then((userAdded) {
                    if (userAdded) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePageScreenWidget()));
                    } else {
                      AppCommonFunctions.showToast(
                          "User Not Added On Firebase", context);
                    }
                  });
                } else {
                  AppCommonFunctions.showToast("Name Can't Be Empty", context);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
