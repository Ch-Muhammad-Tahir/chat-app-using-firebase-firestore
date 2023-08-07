import 'package:chat_app/utils/app_strings.dart';
import 'package:chat_app/utils/media_query.dart';
import 'package:chat_app/widgets/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHomePageAppBar extends StatelessWidget {
  const CustomHomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: GetScreenSize.getScreenHeight(context) * 0.12,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                style: TextStyle(
                    fontSize: GetScreenSize.getScreenWidth(context) * 0.045),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                    hintText: AppCommonStrings.sendMessage,
                    border: InputBorder.none),
              ),
            ),
          ),
          const CustomSizedBox(
            width: 20,
          ),
          Container(
            height: GetScreenSize.getScreenHeight(context) * 0.12,
            width: GetScreenSize.getScreenWidth(context) * 0.14,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.mode_sharp),
            ),
          )
        ],
      ),
    );
  }
}
