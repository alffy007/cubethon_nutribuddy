import 'package:cubethon_nutribuddy/db/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'chatscreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int calorie = 0;
  @override
  void initState() {
    setState(() {
      DataBaseMethods().getUserData().then((value) {
        setState(() {
          calorie = value.get('caloire');
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff43B173).withOpacity(0.4),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1690608480~exp=1690609080~hmac=07f58506219bb34c2fc404014b3ef2ca0d468610d222b2f5e95ebfaf8f98f429'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello Jack',
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Text(
                        'Good Learner',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
                  ),
                  Container(width: MediaQuery.of(context).size.width - 300),
                  const CircleAvatar(
                      maxRadius: 22,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Icon(
                        Icons.notifications,
                        color: Color(0xff43B173),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Today\'s target',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff43B173),
                ),
              ),
            ),
            CalorieDiet(calorie: calorie),
            const DietStatus(),
            const Chatbotopen(),
          ],
        ),
      )),
    );
  }
}

class Chatbotopen extends StatelessWidget {
  const Chatbotopen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: GestureDetector(
        onTap: () {
          // Handle the button tap here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        child: Material(
            elevation: 2,
            shadowColor: Colors.lightGreen,
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 35.h,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'assets/images/bot.jpg',
                      fit: BoxFit.cover,
                      height: 220,
                      width: 345,
                    ),
                  ),
                  Text('\"say Hello to Nutribuddy..\"',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xff43B173),
                      )),
                ],
              ),
            )),
      ),
    );
  }
}

class CalorieDiet extends StatelessWidget {
  const CalorieDiet({
    super.key,
    required this.calorie,
  });

  final int calorie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            color: const Color(0xff43B173),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Calories',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Text(
                      calorie.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                const Text(
                  '🔥',
                  style: TextStyle(fontSize: 50),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Burned Calories',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Text(
                      '400 cal',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DietStatus extends StatelessWidget {
  const DietStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.w),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 100,
          width: 375,
          decoration: BoxDecoration(
            color: const Color(0xff43B173),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Diet Plan',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Text(
                      'Keito',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  '🥩',
                  style: TextStyle(fontSize: 50),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Days Completed',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      Text(
                        '20 Days',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
