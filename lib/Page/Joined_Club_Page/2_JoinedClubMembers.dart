import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Club/JoinedClubProvider.dart';
import 'package:idiot_community_club_app/Providers/Club/current_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/joined_club_member_provider.dart';

class JoinedClubMembers extends ConsumerStatefulWidget {
  const JoinedClubMembers({super.key});

  @override
  ConsumerState<JoinedClubMembers> createState() => _JoinedClubMembersState();
}

class _JoinedClubMembersState extends ConsumerState<JoinedClubMembers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Club club = ModalRoute.of(context)!.settings.arguments as Club;
      if (club != null) {
        fetchJoinedClubMembers(ref, club.clubId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(joinedClubMembersProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 0,
          ), // Optional padding for aesthetics
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Navigate back
            },
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensure Row takes only necessary space
              children: [const Icon(Icons.arrow_back, color: Colors.white)],
            ),
          ),
        ),
        title: Text("Club Members", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body: members.length > 0
          ? ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) => getListTile(members[index]),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
    );
  }
}

Widget getListTile(ClubMember user) {
  return Card(
    child: ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:
            getUserImage(user.profileImage), // Local image fallback
        onBackgroundImageError: (_, __) =>
            const Icon(Icons.person, size: 30, color: Colors.grey),
      ),
      title: Text(
        "${user.userName}",
      ),
    ),
  );
}
