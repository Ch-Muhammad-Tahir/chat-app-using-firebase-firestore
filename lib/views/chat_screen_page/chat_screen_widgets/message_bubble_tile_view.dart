import 'package:flutter/material.dart';

import '../../../utils/media_query.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;
  var receiverBubbleRaduis = const BorderRadius.only(
      bottomRight: Radius.circular(15),
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15));
  var senderBubbleRaduis = const BorderRadius.only(
      bottomLeft: Radius.circular(15),
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15));

  @override
  Widget build(BuildContext context) {
    var fontSize = GetScreenSize.getScreenWidth(context) * 0.039;
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey[300],
              borderRadius:
                  isCurrentUser ? senderBubbleRaduis : receiverBubbleRaduis),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: fontSize,
                  color: isCurrentUser ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
