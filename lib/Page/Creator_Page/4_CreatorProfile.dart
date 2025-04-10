import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import '../../Providers/creator_provider.dart';

class CreatorProfile extends ConsumerStatefulWidget {
  const CreatorProfile({super.key});

  @override
  ConsumerState<CreatorProfile> createState() => _CreatorProfileState();
}

class _CreatorProfileState extends ConsumerState<CreatorProfile> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File selectedImage = File(pickedFile.path);

      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text("Confirm Profile Photo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.file(selectedImage,
                      width: 100, height: 100, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                const Text(
                    "Do you want to use this photo as your new profile picture?"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Cancel
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  setState(() => _image = selectedImage); // Update UI
                  _uploadPhoto(selectedImage); // Upload
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _uploadPhoto(File imageFile) async {
    final creator = ref.read(creatorProvider);
    if (creator == null) return;

    // You should upload to a real image hosting service. Here we simulate with path.
    final fakeUploadedUrl = imageFile.path;

    final uri = Uri.parse(
        "http://localhost:8080/api/creator/edit-profile?creatorId=${creator.id}&photo=$fakeUploadedUrl");
    final response = await http.put(uri);
    final resBody = jsonDecode(response.body);
    print(resBody);
    setState(() {});
    if (resBody["success"] == true) {
      final updatedCreator = Creator.fromJson(resBody["data"]);
      final updatedCreator1 = creator.copyWith(photo: updatedCreator.photo);
      ref.read(creatorProvider.notifier).state = updatedCreator1;
      setState(() {}); // to refresh UI

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Profile Updated"),
            content: const Text("Your profile photo was updated successfully."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // close dialog
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to update photo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final creator = ref.watch(creatorProvider);
    final Size screen = MediaQuery.of(context).size;

    final String? photoPath = _image?.path ?? creator?.photo;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screen.height / 2.8,
                width: screen.width,
                decoration: BoxDecoration(
                  gradient: ButtonComponents.myGradient,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: photoPath != null
                                ? (photoPath.startsWith('http')
                                    ? Image.network(photoPath,
                                        fit: BoxFit.cover)
                                    : Image.file(File(photoPath),
                                        fit: BoxFit.cover))
                                : Image.asset("assets/images/IdiotLogo.png"),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Level:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            Text("Community Owner",
                                style: TextStyle(
                                    color: Color(0xFFFFDC51), fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 31,
                            width: 31,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: ButtonComponents.myGradientLogo(
                                Icons.edit_square),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              _getMyProfile(
                  Icons.person_2_outlined, "Name: ${creator?.name ?? '-'}"),
              _getMyLine(),
              _getMyProfile(
                  Icons.email_outlined, "Email: ${creator?.email ?? '-'}"),
              _getMyLine(),
              InkWell(
                onTap: () => Navigator.pushNamed(context, "/"),
                child: _getMyProfile(Icons.logout, "Logout"),
              ),
              _getMyLine(),
            ],
          ),
          const Flexible(child: SizedBox()),
        ],
      ),
    );
  }

  Container _getMyProfile(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.only(left: 110, top: 10, bottom: 10),
      child: Row(
        children: [
          ButtonComponents.myGradientLogo(icon),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Divider _getMyLine() {
    return const Divider(color: Color.fromARGB(84, 0, 0, 0), thickness: 2);
  }
}
