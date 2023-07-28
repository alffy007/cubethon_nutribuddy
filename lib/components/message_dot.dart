import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageStatusDot extends StatelessWidget {
  const MessageStatusDot({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color dotColor(String status) {
      switch (status) {
        case 'not_sent':
          return const Color(0xFFFF575F);
        case 'not_view':
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
        case 'viewed':
          return const Color(0xFF43b173);
          break;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 1.h),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotColor(status),
      ),
      child: Icon(
        status == 'not_sent' ? Icons.close : Icons.done,
        size: 7.sp,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
