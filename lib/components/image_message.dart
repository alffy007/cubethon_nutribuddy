
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({super.key, required this.message});
  final DocumentSnapshot message;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
              'https://img.freepik.com/free-photo/penne-pasta-tomato-sauce-with-chicken-tomatoes-wooden-table_2829-19744.jpg?w=900&t=st=1690478007~exp=1690478607~hmac=b6e9c3b8cfb768cfb32ab2bc8447a86a99cefe2e2c11de8bd4ac7b629b38d050'),
        ),
      ),
    );
  }
}

