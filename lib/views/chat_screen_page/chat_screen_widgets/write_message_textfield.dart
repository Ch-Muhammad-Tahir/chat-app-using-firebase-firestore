import 'package:flutter/material.dart';

class WriteMessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendTab;
  const WriteMessageTextField(
      {super.key, required this.controller, required this.onSendTab});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, bottom: 10),
          fillColor: Colors.white,
          filled: true,
          hintText: "Type something....",
          suffix: FloatingActionButton.small(
              onPressed: onSendTab,
              elevation: 0,
              child: const Icon(Icons.send))),
      minLines: 1,
      maxLines: 5,
    );
  }
}
