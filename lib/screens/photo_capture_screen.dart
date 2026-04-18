import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/photo_service.dart';
import 'full_screen_view.dart';

class PhotoCaptureScreen extends StatefulWidget {
  const PhotoCaptureScreen({super.key});

  @override
  State<PhotoCaptureScreen> createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  final PhotoService _photoService = PhotoService();
  File? _selectedImage;

  Future<void> _handleImageAction(ImageSource source) async {
    final xFile = await _photoService.pickImage(source);
    if (xFile != null) {
      setState(() {
        _selectedImage = File(xFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Photo Capture & Preview"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Hiển thị ảnh preview
          GestureDetector(
            onTap: () {
              if (_selectedImage != null) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenView(imagePath: _selectedImage!.path)));
              }
            },
            child: Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
              child: _selectedImage != null
                  ? Hero(tag: 'photo_hero', child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.file(_selectedImage!, fit: BoxFit.cover)))
                  : const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo, size: 50, color: Colors.grey), Text("Chưa có ảnh nào được chọn")]),
            ),
          ),
          const Spacer(),
          // Nút bấm
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton("Gallery", Icons.photo_library, () => _handleImageAction(ImageSource.gallery)),
              _buildActionButton("Camera", Icons.camera_alt, () => _handleImageAction(ImageSource.camera)),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(onPressed: onTap, icon: Icon(icon), label: Text(label), style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)));
  }
}