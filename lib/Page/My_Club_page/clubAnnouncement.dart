import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Helper/MyImagePicker.dart';
import 'package:idiot_community_club_app/Providers/Club/club_announcement_provider.dart';
import 'package:idiot_community_club_app/Providers/Club/my_created_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

class MyClubAnnouncemnt extends ConsumerStatefulWidget {
  const MyClubAnnouncemnt({super.key});

  @override
  ConsumerState<MyClubAnnouncemnt> createState() => _MyClubAnnouncemntState();
}

class _MyClubAnnouncemntState extends ConsumerState<MyClubAnnouncemnt> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendAnnouncement(int leaderId, int clubId, int communityId) async {
    if (messageController.text.isNotEmpty) {
      await postAnnouncement(
        ref: ref,
        leaderId: leaderId,
        clubId: clubId,
        communityId: communityId,
        message: messageController.text.trim(),
      );
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final member = ref.watch(memberProvider);
    final club = ref.watch(myCreatedClubStateProvider);
    final community = ref.watch(currentCommunityProvider);
    final myclubName = club?.clubName;
    final screen = MediaQuery.of(context).size;

    final announcementsAsync = ref.watch(
      clubAnnouncementProvider((member?.id ?? 0, club?.clubId ?? 0)),
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [Icon(Icons.arrow_back, color: Colors.white)],
          ),
        ),
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: Container(
                height: 60,
                width: 60,
                color: Colors.white,
                child: buildClubImage(club!.clubLogo),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "$myclubName",
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
            onSelected: (value) {
              if (value == "Page1")
                Navigator.pushNamed(context, '/myClubMember');
              else if (value == "Page2")
                Navigator.pushNamed(context, '/myClubMemberRequest');
              else if (value == "Page3")
                Navigator.pushNamed(context, '/myClubDetail');
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Page1", child: Text("Club Member")),
              PopupMenuItem(value: "Page2", child: Text("Club Member Request")),
              PopupMenuItem(value: "Page3", child: Text("Club Detail")),
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
                reverse: true,
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final ann = announcements.reversed.toList()[index];
                  return Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 20, bottom: 5),
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
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
                            mainAxisAlignment: MainAxisAlignment.end,
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
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
      bottomNavigationBar: club != null && member != null && community != null
          ? Stack(
              children: [
                Container(
                  height: screen.height / 9,
                  width: screen.width,
                  decoration:
                      BoxDecoration(gradient: ButtonComponents.myGradient),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 320,
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            filled: true,
                            fillColor: const Color.fromARGB(125, 255, 255, 255),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _sendAnnouncement(
                            member.id, club.clubId, community.communityId),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
