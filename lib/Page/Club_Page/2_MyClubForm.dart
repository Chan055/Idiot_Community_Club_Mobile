import 'dart:io';

import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:image_picker/image_picker.dart';

class MyClubForm extends StatefulWidget {
  const MyClubForm({super.key});

  @override
  State<MyClubForm> createState() => _MyClubFormState();
}

class _MyClubFormState extends State<MyClubForm> {
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
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Barcomponents.idiotClubBar(screen, context),
          SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Cardcomponent.getMyOwnGradientBox(
                height: 530,
                width: 320,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: _pickImageFromGallery,
                              child: ClipOval(
                                child: Container(
                                  height: 105,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child:
                                      image != null
                                          ? Image.file(
                                            image!,
                                            width: 200,
                                            height: 200,
                                          )
                                          : Image.asset(
                                            "assets/images/UploadImage.png",
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text("Club Name", style: TextStyle(color: Colors.white)),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "The reason you want to create the club",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Club Description",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onDoubleTap: () {
                            Navigator.pushNamed(context, "/myCreatedClub");
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            child: ButtonComponents.getLogInBorder("Request"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Barcomponents.getIdiotClubNav(screen, context),
    );
  }
}
