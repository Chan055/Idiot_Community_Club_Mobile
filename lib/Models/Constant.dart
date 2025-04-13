import 'dart:io';

import 'package:flutter/material.dart';

const String BASE_URL = "http://localhost:8080";

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
