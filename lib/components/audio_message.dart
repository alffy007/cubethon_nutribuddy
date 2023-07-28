import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class AudioMessage extends StatelessWidget {
  const AudioMessage({super.key, required this.message});
  final DocumentSnapshot message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: const Color(0xFF43b173).withOpacity( message.get('isSender')? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color:  message.get('isSender') ? Colors.white : const Color(0xFF43b173),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color:  message.get('isSender')
                        ? Colors.white
                        : const Color(0xFF43b173).withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:  message.get('isSender')
                              ? Colors.white
                              : const Color(0xFF43b173)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color:  message.get('isSender') ? Colors.white : null,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}