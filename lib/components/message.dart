import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubethon_nutribuddy/components/audio_message.dart';
import 'package:cubethon_nutribuddy/components/message_dot.dart';
import 'package:cubethon_nutribuddy/components/text_message.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'image_message.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.message});

  final DocumentSnapshot message;

  @override
  Widget build(BuildContext context) {
    Widget messagecontent(DocumentSnapshot message) {
      switch (message.get('messageType')) {
        case 'text':
          return TextMessage(message: message);
        case 'audio':
          return AudioMessage(
            message: message,
          );
        case 'image':
          return ImageMessage(
            message: message,
          );
          break;
        default:
          return const SizedBox();
      }
    }

    String url =
        'https://img.freepik.com/premium-photo/buddy-robot-with-computer-dextop_352934-3.jpg?w=900';
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Row(
        mainAxisAlignment: message.get('isSender')
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.get('isSender')) ...[
            CircleAvatar(
              radius: 4.w,
              backgroundImage: NetworkImage(url),
            )
          ],
          SizedBox(
            width: 2.w,
          ),
          messagecontent(message),
          if (message.get('isSender'))
            MessageStatusDot(
              status: message.get('messageStatus'),
            )
        ],
      ),
    );
  }
}
