import 'package:chat_app/models/user.dart';
import 'package:chat_app/utils/app_strings.dart';
import 'package:chat_app/utils/media_query.dart';
import 'package:chat_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class ChatListTileView extends StatelessWidget {
  final ChatUser user;
  final VoidCallback onTap;
  const ChatListTileView({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: GetScreenSize.getScreenHeight(context) * 0.1,
            width: GetScreenSize.getScreenWidth(context),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Stack(children: [
                    CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        backgroundImage:
                            NetworkImage(AppCommonStrings.dummyImage),
                        radius: GetScreenSize.getScreenHeight(context) * 0.035),
                    Positioned(
                        right: -7,
                        bottom: 3,
                        child: Container(
                          width: GetScreenSize.getScreenHeight(context) * 0.039,
                          height: GetScreenSize.getScreenWidth(context) * 0.039,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3.5),
                            shape: BoxShape.circle,
                            color: Colors.greenAccent
                                .shade400, // Change the color as needed
                          ),
                        ))
                  ]),
                  CustomSizedBox(
                      width: GetScreenSize.getScreenWidth(context) * 0.03),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(user.name,
                              style: TextStyle(
                                fontSize:
                                    GetScreenSize.getScreenWidth(context) *
                                        0.050,
                              ),
                              overflow: TextOverflow.ellipsis),
                          Text("Perfert will Check it",
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize:
                                      GetScreenSize.getScreenWidth(context) *
                                          0.030),
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ),
                  ),
                  const CustomSizedBox(width: 25),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "09:12 AM",
                      style: TextStyle(
                          fontSize:
                              GetScreenSize.getScreenWidth(context) * 0.030),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
