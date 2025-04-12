import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';

class MyClubForm extends ConsumerStatefulWidget {
  const MyClubForm({super.key});

  @override
  ConsumerState<MyClubForm> createState() => _MyClubFormState();
}

class _MyClubFormState extends ConsumerState<MyClubForm> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitClubForm() async {
    final member = ref.read(memberProvider);
    final currentCommunity = ref.read(currentCommunityProvider);

    if (member == null || currentCommunity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Missing user or community info")),
      );
      return;
    }

    final uri = Uri.parse("$BASE_URL/api/member/create-my-club");
    final body = {
      "userId": member.id,
      "communityId": currentCommunity.communityId,
      "clubName": clubNameController.text.trim(),
      "clubDescription": descriptionController.text.trim(),
      "clubLogo": image?.path ?? "https://example.com/gaming.jpg",
      "reasonToCreateClub": reasonController.text.trim(),
    };

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    final resBody = jsonDecode(response.body);
    if (resBody["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Success ${resBody["message"]}")),
      );
      final updatedCreator = currentCommunity.copyWith(isLeader: true);
      ref.read(currentCommunityProvider.notifier).state = updatedCreator;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed: ${resBody["message"]}")),
      );
    }
  }

  @override
  void dispose() {
    clubNameController.dispose();
    reasonController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Barcomponents.idiotClubBar(screen, context),
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
                                    child: image != null
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
                        Text("Club Name",
                            style: TextStyle(color: Colors.white)),
                        TextFormField(
                          controller: clubNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "The reason you want to create the club",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: reasonController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Club Description",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: InkWell(
                            onDoubleTap: () {
                              if (image != null) {
                                _submitClubForm();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("❌ Please select an image")),
                                );
                              }
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
      ),
      // bottomNavigationBar: Barcomponents.getIdiotClubNav(screen, context),
    );
  }
}
