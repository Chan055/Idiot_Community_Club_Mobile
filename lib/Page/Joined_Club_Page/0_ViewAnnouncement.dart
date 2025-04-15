import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Helper/MyImagePicker.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Club/JoinedClubProvider.dart';
import 'package:idiot_community_club_app/Providers/Club/current_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/read_post_provider.dart';

class ViewAnnouncement extends ConsumerStatefulWidget {
  const ViewAnnouncement({super.key});

  @override
  ConsumerState<ViewAnnouncement> createState() => _ViewAnnouncementState();
}

class _ViewAnnouncementState extends ConsumerState<ViewAnnouncement> {
  Future<void> leaveClub(
      WidgetRef ref, int userId, int clubId, int communityId) async {
    final uri = Uri.parse("$BASE_URL/api/member/club/leave-club");

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "clubId": clubId,
        "communityId": communityId,
      }),
    );

    final data = jsonDecode(response.body);

    if (data['success'] == true) {
      // ✅ Remove the left club from provider list
      // final currentClubs = ref.read(joinedClubsProvider);
      // final updatedClubs =
      //     currentClubs.where((club) => club.clubId != clubId).toList();
      // ref.read(joinedClubsProvider.notifier).state = updatedClubs;
      fetchJoinedClubs(ref, userId, communityId);

      // Optionally show success
      print("✅ Club left successfully.");
    } else {
      throw Exception(data['message'] ?? "Failed to leave club");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Club club = ModalRoute.of(context)!.settings.arguments as Club;
    final community = ref.watch(currentCommunityProvider);
    final clubName = club.clubName;
    final announcementsAsync =
        ref.watch(clubPostsProvider((club.clubId, community!.communityId)));

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: club.clubLogo.contains("/")
                  ? Container(
                      height: 60,
                      width: 60,
                      color: Colors.white,
                      child: buildClubImage(club.clubLogo),
                    )
                  : const Icon(Icons.image, size: 50, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(
              clubName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: Colors.white54,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) async {
              if (value == "Page1") {
                Navigator.pushNamed(context, '/joinedClubMembers',
                    arguments: club);
              } else if (value == "Page2") {
                Navigator.pushNamed(context, '/joinedClubDetail',
                    arguments: club);
              } else if (value == "Page3") {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Leave Club"),
                    content:
                        const Text("Are you sure you want to leave this club?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Leave"),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final user = ref.read(memberProvider);
                  final community = ref.read(currentCommunityProvider);
                  final clubId =
                      club.clubId; // ✅ Make sure club is passed as an argument

                  if (user != null && community != null) {
                    await leaveClub(
                        ref, user.id, clubId, community.communityId);

                    // Optional: Navigate back after leaving
                    Navigator.pop(context);
                  }
                }
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Page1", child: Text("Club Member")),
              PopupMenuItem(value: "Page2", child: Text("Club Detail")),
              PopupMenuItem(value: "Page3", child: Text("Leave Club")),
            ],
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body: announcementsAsync.when(
        data: (announcements) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final ann = announcements.reversed.toList()[index];
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 20, bottom: 5),
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        gradient: ButtonComponents.myGradient,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            child: Text(
                              ann.message,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${ann.createdAt.hour}:${ann.createdAt.minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
