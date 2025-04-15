import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? image;
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Convert XFile to File
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Image.file(image!, width: 200, height: 200)
                : const Text("No Image Selected"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text("Pick Image from Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCommunityImage(String? imagePath) {
  if (imagePath == null || imagePath.isEmpty) {
    return Image.asset("assets/images/UploadImage.png", fit: BoxFit.cover);
  } else {
    Uint8List imageBytes = base64Decode(imagePath);
    return Image.memory(imageBytes, fit: BoxFit.cover);
  }
}

Widget buildClubImage(String? imagePath) {
  if (imagePath != null && isBase64(imagePath)) {
    Uint8List imageBytes = base64Decode(imagePath);
    return Image.memory(imageBytes, fit: BoxFit.cover);
  } else {
    return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
  }
}

bool isBase64(String str) {
  final base64Regex = RegExp(r'^[A-Za-z0-9+/=]+\Z');
  if (!base64Regex.hasMatch(str)) return false;

  try {
    base64Decode(str);
    return true;
  } catch (_) {
    return false;
  }
}
