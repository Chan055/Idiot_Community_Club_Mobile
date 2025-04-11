import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Providers/Member/view_community_provider.dart';

class CommunityMemberRequest extends ConsumerStatefulWidget {
  const CommunityMemberRequest({super.key});

  @override
  ConsumerState<CommunityMemberRequest> createState() =>
      _CommunityMemberRequestState();
}

class _CommunityMemberRequestState
    extends ConsumerState<CommunityMemberRequest> {
  final TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> submitRequest(int communityId) async {
    final uri = Uri.parse('$BASE_URL/api/member/join-community');

    final user = ref.read(memberProvider);
    final int userId = user?.id ?? 1; // fallback in case user is null

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "communityId": communityId,
          "userId": userId,
          "requestDescription": reasonController.text,
          "status": "PENDING",
        }),
      );

      final resBody = jsonDecode(response.body);
      print("Response: $resBody");

      if (resBody["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Request sent successfully")),
        );
        Navigator.pop(context);
      } else {
        final message = resBody["message"] ?? "Something went wrong";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ $message")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final community =
        ModalRoute.of(context)!.settings.arguments as ViewCommunity;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(gradient: ButtonComponents.myGradient)),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: (Uri.tryParse(community.image)
                                        ?.hasAbsolutePath ==
                                    true &&
                                (community.image.startsWith("http") ||
                                    community.image.startsWith("https")))
                            ? Image.network(community.image, fit: BoxFit.cover)
                            : (community.image.startsWith("/"))
                                ? Image.file(File(community.image),
                                    fit: BoxFit.cover)
                                : Image.asset("assets/images/IdiotLogo.png",
                                    fit: BoxFit.cover),
                      ),
                    ),
                    Text(
                      community.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 320,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(26, 255, 255, 255),
                        border: Border.all(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        community.description,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      height: 350,
                      width: 320,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(180, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          ButtonComponents.getMyGradientText(
                              "Community Member Request Form", 18),
                          const SizedBox(height: 10),
                          ButtonComponents.getMyGradientText(
                            "The reason why you want to join this Community",
                            11,
                          ),
                          Container(
                            height: 100,
                            width: 230,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              gradient: ButtonComponents.myGradient,
                            ),
                            child: Form(
                              child: TextFormField(
                                controller: reasonController,
                                cursorColor: Colors.white,
                                maxLines: 3,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration.collapsed(
                                  hintText: "Why do you want to join?",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(57, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            height: 40,
                            width: 100,
                            child: InkWell(
                              onTap: () => submitRequest(community.id),
                              child: ButtonComponents.getGradientBox(
                                text: "Request",
                                size: 15,
                                myRadius: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
