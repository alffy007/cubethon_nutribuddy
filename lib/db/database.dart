import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DataBaseMethods {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: username)
        .get();
  }

  getUserData() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where('profile_pic')
        .get();
  }

  uploadUserInfo(userMap, String username) {
    FirebaseFirestore.instance.collection("users").doc(username).set(userMap);
  }

  updateUserInfo(String userName) {
    FirebaseFirestore.instance.collection("users").doc(userName);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('Chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRoom(String userName) async {
    return FirebaseFirestore.instance
        .collection('chatroom')
        .where('users', arrayContains: userName)
        .snapshots();
  }

  Future<void> makePostRequest(String sentence) async {
    const url =
        'https://web-production-1014.up.railway.app/add/'; // Replace with your API endpoint

    // The data you want to send in the POST request
    Map<String, dynamic> postData = {
      "diet": "kieto",
      "weight": "60",
      "height": "5.7",
      "age": "23",
      "healthissues": "diabetic",
      "food": "",
      "sentence": sentence
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(postData), // Encode the data as JSON
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response data
        print('Response: ${response.body}');
      } else {
        // Request failed with an error status code, handle the error
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // An error occurred while making the request
      print('Error: $e');
    }
  }

// Function to upload the recorded audio file to Firebase Storage
  Future<void> uploadAudioToFirebase(audiopath) async {
    if (audiopath != null) {
      File audioFile = File(audiopath!);
      if (await audioFile.exists()) {
        try {
          String fileName = path.basename(audiopath!);
          Reference ref = FirebaseStorage.instance.ref().child(fileName);
          await ref.putFile(audioFile);
          print('Audio uploaded successfully.');
        } catch (e) {
          print('Error uploading audio to Firebase: $e');
        }
      } else {
        print('File not found at path: $audiopath');
      }
    } else {
      print('No recorded audio to upload.');
    }
  }


  Future<void> uploadAudioFromAssets(String assetPath) async {
    // Load the audio file from assets

    ByteData byteData = await rootBundle.load(assetPath);
    List<int> bytes = byteData.buffer.asUint8List();

    // Get the temporary directory on the device
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/sample.m4a';

    // Write the bytes to the temporary file
    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(bytes);
    // Now you can upload the audio file using the uploadAudio function from the previous example
    await uploadAudio(tempFile);

    // Optional: Delete the temporary file after the upload is complete
    await tempFile.delete();
  }

  Future<void> uploadAudio(File audioFile) async {
    // Replace "your_api_endpoint" with the actual API endpoint where you want to upload the audio
    var apiUrl = Uri.parse(
        'https://api-inference.huggingface.co/models/openai/whisper-medium');

    try {
      // Create the multipart request to upload the audio file
      var request = http.MultipartRequest('POST', apiUrl);

      // Set any additional headers or fields if required
      request.headers['Authorization'] =
          'Bearer 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';
      // request.fields['user_id'] = 'user_id_here';

      // Add the audio file to the request
      var audioStream = http.ByteStream(audioFile.openRead());
      var length = await audioFile.length();
      var multipartFile = http.MultipartFile('data', audioStream, length,
          filename: audioFile.path.split('/').last);
      request.files.add(multipartFile);

      // Send the request and await the response
      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        print(jsonData);
      } else {
        print('Failed to upload audio. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading audio: $e');
    }
  }
  
}
