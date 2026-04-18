import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenView extends StatelessWidget {
  final String imagePath;

  const FullScreenView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: Hero( // Hiệu ứng chuyển cảnh mượt mà
          tag: 'photo_hero',
          child: Image.file(File(imagePath), fit: BoxFit.contain),
        ),
      ),
    );
  }
}