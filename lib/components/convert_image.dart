import 'dart:convert';
import 'package:cubethon_nutribuddy/db/database.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ConverterImage {
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  uploadImage(File image) async {
    // setState(() {
    //   showSpinner = true;
    // });

    String food = "";

    List<int> imageBytes = image!.readAsBytesSync();

    var apiUrl = Uri.parse(
        'https://api-inference.huggingface.co/models/rajistics/finetuned-indian-food'); // Replace with your API endpoint

    Map<String, String> headers = {
      'Content-Type':
          'image/jpeg', // Replace with the appropriate content-type for your image
      'Authorization': 'Bearer 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',
    };

    try {
      final response =
          await http.post(apiUrl, headers: headers, body: imageBytes);

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
        List<dynamic> jsonData = jsonDecode(response.body);
        food = jsonData[0]['label'];
        print(food);
        // Handle success response here
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        // Handle error response here
      }
    } catch (e) {
      print('Error uploading image: $e');
      // Handle any exceptions or network-related errors here
    }
    return food;
  }
}
