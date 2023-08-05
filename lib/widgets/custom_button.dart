import 'package:chat_app/utils/media_query.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color color;
  final VoidCallback onTab;
  const CustomButton(
      {super.key,
      required this.height,
      required this.text,
      required this.color,
      required this.onTab,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTab,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: GetScreenSize.getScreenWidth(context) * 0.05),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
