import 'package:cubethon_nutribuddy/db/database.dart';
import 'package:cubethon_nutribuddy/views/chatviewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'dashboard.dart';

class SixthPage extends StatefulWidget {
  SixthPage(
      {super.key,
      required this.age,
      required this.gender,
      required this.height,
      required this.weight,
      required this.healthissues});
  late int age;
  late String gender;
  late int height;
  late int weight;
  late String healthissues;

  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  @override
  late final _veg_or_nonveg;
  late final List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              const Padding(padding: EdgeInsets.all(20)),
              Text(
                'One Final Question',
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "I am a",
                style: GoogleFonts.getFont("Poppins",
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                    )),
              ),
              const SizedBox(height: 50),
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            const vegOrNonveg = "vegan";
                            print(
                                '------------------------$vegOrNonveg---------');
                            String vOrN = vegOrNonveg.toString();
                            print(widget.age);
                            print(widget.gender);
                            print(widget.height);
                            print(widget.weight);
                            print(widget.healthissues);

                       updateAbout(
                                widget.age,
                                widget.height,
                                widget.weight,
                                widget.gender,
                                widget.healthissues,
                                vOrN);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dietviewer()),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/veg.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            padding: const EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () async {
                            const vegOrNonveg = "nonvegan";
                            print(
                                '------------------------$vegOrNonveg---------');
                            String vOrN = vegOrNonveg.toString();
                            print(widget.age);
                            print(widget.gender);
                            print(widget.height);
                            print(widget.weight);
                            print(widget.healthissues);
                             updateAbout(
                                widget.age,
                                widget.height,
                                widget.weight,
                                widget.gender,
                                widget.healthissues,
                                vOrN);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dietviewer()),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/non.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            padding: const EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 55,
                width: 350,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 253, 190, 208)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 243, 238, 238))))),
                  onPressed: () async {
                    const vegOrNonveg = " ";
                    try {
                      print('------------------------$vegOrNonveg---------');
                      String vOrN = vegOrNonveg.toString();
                      print(widget.age);
                      print(widget.gender);
                      print(widget.height);
                      print(widget.weight);
                      print(widget.healthissues);
                      data = await updateAbout(
                          widget.age,
                          widget.height,
                          widget.weight,
                          widget.gender,
                          widget.healthissues,
                          vOrN);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                      );
                    } catch (e) {}
                  },
                  child: Text(
                    "All Done!",
                    style: GoogleFonts.getFont("Poppins",
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  updateAbout(age, height, weight, gender, healthissues, vOrN) async {
    Map<String, dynamic> messagemap = {
      "age": age.toString(),
      "height": height.toString(),
      "weight": weight.toString(),
      "healthissue": healthissues.toString(),
      "gender": gender.toString(),
      "v_or_n": vOrN.toString()

      // "dietname":dietname;
      // "dietinstruction":dietinstructions;
    };
    await DataBaseMethods().updateAbout("about", messagemap);

  }
}
