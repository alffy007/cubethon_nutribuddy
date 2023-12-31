import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page5.dart';

class ForthPage extends StatefulWidget {
  ForthPage(
      {super.key,
      required this.age,
      required this.gender,
      required this.height});
  late int age;
  late String gender;
  late int height;

  @override
  State<ForthPage> createState() => _ForthPageState();
}

class _ForthPageState extends State<ForthPage> {
  @override
  late final TextEditingController _weight;
  @override
  void initState() {
    _weight = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: <Widget>[
                const Padding(padding: EdgeInsets.all(20)),
                Text(
                  'How Heavy are You?',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 40,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/weight.png',
                  height: 300,
                  width: 300,
                ),
                Text(
                  "I weigh",
                  style: GoogleFonts.getFont("Poppins",
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      )),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextField(
                      cursorColor: const Color(0xFFea4c89),
                      cursorWidth: 5,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _weight,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "Weight in kg",
                      )),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 55,
                  width: 350,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 253, 190, 208)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 243, 238, 238))))),
                    onPressed: () async {
                      final weight = _weight.text;
                      try {
                        print('------------------------$weight---------');
                        int w = int.parse(_weight.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FifthPage(
                                    age: widget.age,
                                    gender: widget.gender,
                                    height: widget.height,
                                    weight: w,
                                  )),
                        );
                      } catch (e) {}
                    },
                    child: Text(
                      'Next',
                      style: GoogleFonts.getFont("Poppins",
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
