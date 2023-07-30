import 'dart:io';

import 'package:cubethon_nutribuddy/components/convert_image.dart';
import 'package:cubethon_nutribuddy/db/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../components/chatmessage_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String url =
      'https://img.freepik.com/premium-photo/buddy-robot-with-computer-dextop_352934-3.jpg?w=900';
  var isListening = false;
  var rad = 25.0;
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  String food = "";
  final recorder = FlutterSoundRecorder();
  late Record audiorecord;
  // late AudioPlayer audioPlayer;
  late FlutterSoundPlayer audioPlayer;
  bool isPlaying = false;
  bool isRecording = false;
  String audiopath = '';
  String imageUrl = '';
  File? image;
  String imagepath = '';
  int index = 0;

  @override
  void initState() {
    // audioPlayer = AudioPlayer();
    audioPlayer = FlutterSoundPlayer();

    audiorecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.closePlayer();
    audiorecord.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audiorecord.hasPermission()) {
        await audiorecord.start(encoder: AudioEncoder.wav);
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('error start rec: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      if (await audiorecord.hasPermission()) {
        String? path = await audiorecord.stop();
        setState(() {
          isRecording = false;
          audiopath = path!;
          print(audiopath);
        });
        if (isPlaying) {
          await audioPlayer.pausePlayer();
        } else {
          await audioPlayer.openPlayer();
          await audioPlayer.startPlayer(
            fromURI: audiopath,
            codec: Codec.aacADTS, // Use the correct codec for M4A files
            whenFinished: () => setState(() => isPlaying = false),
          );
        }
        setState(() => isPlaying = !isPlaying);
      }
    } catch (e) {
      print('error start rec: $e');
    }
    Map<String, dynamic> audiomap = {
      "message": "",
      "isSender": true,
      "time": DateTime.now().millisecondsSinceEpoch,
      "messageType": 'audio',
      "messageStatus": 'viewed'
    };
    dataBaseMethods.addAudioMessage('Alfred jimmy', audiomap);
    dataBaseMethods.uploadAudioToFirebase(audiopath);
    dataBaseMethods.uploadAudioFromAssets(audiopath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xff43B173),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Nutribuddy',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.radio_button_checked_rounded,
                      size: 8.sp,
                      color: Colors.lightGreenAccent,
                    ),
                    SizedBox(
                      width: 4.sp,
                    ),
                    Text(
                      'Online',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          letterSpacing: .5,
                          fontSize: 10.sp,
                          color: const Color.fromARGB(255, 255, 240, 240),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 90,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(url),
            )
          ],
        ),
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).dialogBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ChatMessageList(),
          sendBar(),
        ],
      ),
    );
  }

  Future pickImage(bool cam) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: cam ? ImageSource.camera : ImageSource.gallery);

      if (image == null) return;
      File? imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
      dynamic result = await ConverterImage().uploadImage(imageTemp);
      food = result as String;
      print(food);
    } on PlatformException {
      print('failed to pik image');
    }
    index = index + 1;
    print(index);
    Reference ref = FirebaseStorage.instance.ref().child("newpic${index}.jpg");
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
    Map<String, dynamic> imageMap = {
      "message": imageUrl,
      "isSender": true,
      "time": DateTime.now().millisecondsSinceEpoch,
      "messageType": 'image',
      "messageStatus": 'viewed'
    };
    dataBaseMethods.addConversationMessage("Alfred jimmy", imageMap);
  }

  sendMessage(controller) {
    if (controller.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": controller.text,
        "isSender": true,
        "time": DateTime.now().millisecondsSinceEpoch,
        "messageType": 'text',
        "messageStatus": 'viewed'
      };
      dataBaseMethods.addConversationMessage("Alfred jimmy", messageMap);
      Future.delayed(const Duration(milliseconds: 1000));
      dataBaseMethods.makePostRequest(controller.text, food);
      setState(() {
        controller.text = "";
      });
    }
  }

  sendBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.75.h, vertical: 1.h),
      child: Row(
        children: [
          Container(
            height: 6.5.h,
            decoration: BoxDecoration(
              color: const Color(0xFF43b173),
              borderRadius: BorderRadius.circular(10.sp),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 32,
                  color: const Color(0xff087949).withOpacity(0.5),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 4.w,
                ),
                GestureDetector(
                  onTap: () {
                    pickImage(true);
                  },
                  child: CircleAvatar(
                    radius: 2.5.h,
                    backgroundColor: const Color(0xff8ed0ab),
                    child: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 6.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: TextFormField(
                      controller: _controller,
                      onFieldSubmitted: (value) {
                        sendMessage(_controller);
                        print(_controller.text);
                      },
                      cursorHeight: 20,
                      cursorColor: Colors.lightGreen[200],
                      autocorrect: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Ask Me...',
                        hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: const Color(0xFFb4e0c7),
                            fontSize: 15.sp,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(false);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //border radius equal to or more than 50% of width
                      ),
                    ),
                    child: const Icon(Icons.image),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 0.75.w,
          ),
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                rad = 34.0;
                startRecording();
              });
            },
            onTapUp: (details) {
              setState(() {
                stopRecording();
                rad = 25.0;
              });
            },
            child: CircleAvatar(
              backgroundColor: const Color(0xFFFF575F),
              radius: rad,
              child: Icon(
                Icons.mic,
                size: rad,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
