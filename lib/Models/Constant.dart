import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

const String BASE_URL = "http://3.106.58.122";

ImageProvider getUserImage(String? photoPath) {
  if (photoPath == null || photoPath.isEmpty) {
    return const AssetImage("assets/images/IdiotLogo.png");
  } else if (photoPath.startsWith("http")) {
    return NetworkImage(photoPath);
  } else if (File(photoPath).existsSync()) {
    return FileImage(File(photoPath));
  } else {
    return const AssetImage("assets/images/IdiotLogo.png");
  }
}

// This function returns a base64-encoded string from an image file
Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64String = base64Encode(imageBytes);
  return base64String;
}
