import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Providers/Creator/community_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../Components/BarComponents.dart';
import '../../Components/ButtonComponents.dart';
import '../../Components/CardComponents.dart';

import '../../Providers/Creator/creator_provider.dart';

class CommunityHomeCreate extends ConsumerStatefulWidget {
  const CommunityHomeCreate({super.key});

  @override
  ConsumerState<CommunityHomeCreate> createState() =>
      _CommunityHomeCreateState();
}

class _CommunityHomeCreateState extends ConsumerState<CommunityHomeCreate> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => image = File(pickedFile.path));
    }
  }

  Future<void> _createCommunity(File image) async {
    final creator = ref.read(creatorProvider);
    if (creator == null) return;

    final uri = Uri.parse("http://localhost:8080/api/creator/create");
    final body = {
      "communityName": nameController.text.trim(),
      "description": descriptionController.text.trim(),
      "image": image.path,
      "communityCreatorId": creator.id,
    };

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    final resBody = jsonDecode(response.body);
    print(resBody);
    if (resBody["success"] == true) {
      final newCommunity = Community.fromJson(resBody["data"]);
      ref.read(communityProvider.notifier).state = newCommunity;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ ${resBody["message"]}")),
      );
      final updatedCreator = creator.copyWith(hasCommunity: true);
      ref.read(creatorProvider.notifier).state = updatedCreator;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed: ${resBody["message"]}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          Cardcomponent.getMyOwnGradientBox(
            height: 480.0,
            width: 320.0,
            child: Column(
              children: [
                Text("Create a Community", style: Cardcomponent.clubTitleStyle),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: ClipOval(
                    child: Container(
                      height: 105,
                      width: 105,
                      color: Colors.white,
                      child: image != null
                          ? Image.file(image!, fit: BoxFit.cover)
                          : Image.asset("assets/images/UploadImage.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text("Community Name", style: TextStyle(color: Colors.white)),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                Text("Description", style: TextStyle(color: Colors.white)),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (image != null) {
                      _createCommunity(image!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("❌ Please select an image")),
                      );
                    }
                  },
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: Text("Create"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
