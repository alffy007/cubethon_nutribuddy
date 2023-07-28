import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

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
    return  FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRoom(String userName) async {
    return  FirebaseFirestore.instance
        .collection('chatroom')
        .where('users', arrayContains: userName)
        .snapshots();
  }

 

Future<void> makePostRequest(String sentence) async {
  const url = 'https://web-production-1014.up.railway.app/add/'; // Replace with your API endpoint

  // The data you want to send in the POST request
  Map<String, dynamic> postData = 
   {
    "diet":"kieto",
    "weight":"60",
    "height":"5.7",
    "age":"23",
    "healthissues":"diabetic",
    "food":"",
    "sentence":sentence

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


}