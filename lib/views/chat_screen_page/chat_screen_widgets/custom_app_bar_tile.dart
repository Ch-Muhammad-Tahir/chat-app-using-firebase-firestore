import 'package:chat_app/utils/media_query.dart';
import 'package:chat_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../utils/app_strings.dart';

class CustomAppBarTile extends StatelessWidget {
  const CustomAppBarTile(
      {super.key, required this.onTab, required this.receiverUser});
  final VoidCallback onTab;
  final ChatUser receiverUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onTab,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(AppCommonStrings.dummyImage),
          maxRadius: 20,
        ),
        const CustomSizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              receiverUser.name,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: GetScreenSize.getScreenWidth(context) * 0.036),
            ),
            Text(
              AppCommonStrings.onlineText,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: GetScreenSize.getScreenWidth(context) * 0.030),
            )
          ],
        )
      ],
    );
  }
}
