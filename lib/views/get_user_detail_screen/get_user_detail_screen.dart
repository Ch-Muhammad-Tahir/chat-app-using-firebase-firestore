import 'dart:io';

import 'package:chat_app/utils/app_strings.dart';
import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/views/home_page/home_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';
import '../../utils/media_query.dart';
import '../../widgets/custom_button.dart';

class GetUserDetailScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  File? _pickedImage;
  GetUserDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    _pickedImage =
        Provider.of<AuthenticationProvier>(context, listen: true).pickedimg;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                Provider.of<AuthenticationProvier>(context, listen: false)
                    .pickedImage()
                    .then((value) {
                  print(value!.absolute);
                });
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage:
                    _pickedImage != null ? FileImage(_pickedImage!) : null,
                child: _pickedImage == null
                    ? const Icon(Icons.person, size: 80)
                    : null, // Display an icon when no image is selected
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: controller,
              decoration:
                  InputDecoration(hintText: AppCommonStrings.enterNameTfHint),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              color: Colors.deepPurple.shade700,
              height: GetScreenSize.getScreenHeight(context) * 0.06,
              text: AppCommonStrings.btnNext,
              width: GetScreenSize.getScreenHeight(context) * 0.30,
              onTab: () {
                String name = controller.text.trim();
                if (name.isNotEmpty && (_pickedImage != null)) {
                  Provider.of<AuthenticationProvier>(context, listen: false)
                      .storeDataOnfirebase(name, context, _pickedImage!)
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
