import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Club/my_all_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

class ClubRequest extends ConsumerStatefulWidget {
  const ClubRequest({super.key});

  @override
  ConsumerState<ClubRequest> createState() => _ClubRequestState();
}

class _ClubRequestState extends ConsumerState<ClubRequest> {
  final TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> submitClubRequest(int clubId) async {
    final member = ref.read(memberProvider);
    final currentCommunity = ref.read(currentCommunityProvider);
    final userId = member?.id;
    final communityId = currentCommunity?.communityId;

    final uri = Uri.parse('$BASE_URL/api/member/join-club');
    final body = {
      "clubId": clubId,
      "communityId": communityId,
      "userId": userId,
      "reasonToJoin": reasonController.text,
    };

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final resBody = jsonDecode(response.body);
      if (resBody["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ ${resBody["message"]}")),
        );
        Navigator.pop(context);
      } else {
        throw Exception(resBody["message"]);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final club = ModalRoute.of(context)!.settings.arguments as Club;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: ButtonComponents.myGradient),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(club.clubLogo),
                      ),
                    ),
                    Text(
                      club.clubName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 320,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(26, 255, 255, 255),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        club.clubDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      height: 350,
                      width: 320,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(180, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            ButtonComponents.getMyGradientText(
                              "Club Member Request Form",
                              18,
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Column(
                                children: [
                                  ButtonComponents.getMyGradientText(
                                    "The reason why you want to join this Club",
                                    11,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 230,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      gradient: ButtonComponents.myGradient,
                                    ),
                                    child: Form(
                                      child: TextFormField(
                                        controller: reasonController,
                                        cursorColor: Colors.white,
                                        maxLines: 3,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration.collapsed(
                                          hintStyle: TextStyle(
                                            color: const Color.fromARGB(
                                              57,
                                              0,
                                              0,
                                              0,
                                            ),
                                          ),
                                          hintText: "hintText",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              height: 40,
                              width: 100,
                              child: GestureDetector(
                                onTap: () => submitClubRequest(club.clubId),
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
