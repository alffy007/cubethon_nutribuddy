import 'package:cubethon_nutribuddy/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Dietviewer extends StatefulWidget {
  const Dietviewer({super.key});

  @override
  State<Dietviewer> createState() => _DietviewerState();
}

class _DietviewerState extends State<Dietviewer> {
  List plan = [
    'Your BMI is approximately 34.9 which is obease category',
    'Need to loose around 15-20 kg',
    'Focus on low carbo foods',
    'Opt for low soduim to manage BP'
        'Avoid packaged products'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 255, 209),
      body: Center(
        child: Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(20),
          child: SafeArea(
            child: Container(
              width: 93.w,
              height: 88.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 255, 242),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Diet Plan',
                    style: GoogleFonts.poppins(fontSize: 30.sp),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: plan.length,
                        itemBuilder: (context, index) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 70
                                  .w, // Set the maximum width of the container (70% of screen width)
                            ),
                            child: Container(
                              margin: EdgeInsets.all(5.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.4.h, vertical: 1.2.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF43b173).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    ),
                                  ),
                                  Text(
                                    plan[index],
                                    // ignore: deprecated_member_use
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.sp),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                      },
                      style: ButtonStyle(
                          iconColor:
                              const MaterialStatePropertyAll(Colors.white),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orange[300])),
                      icon: const Icon(Icons.navigate_next),
                      label: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
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
