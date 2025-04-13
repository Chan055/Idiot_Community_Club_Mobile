import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Creator/CommunityMembersProvider.dart';
import 'package:idiot_community_club_app/Providers/Creator/community_provider.dart';
import 'package:idiot_community_club_app/Providers/Creator/creator_provider.dart';

class CommunityMemberList extends ConsumerStatefulWidget {
  const CommunityMemberList({super.key});

  @override
  ConsumerState<CommunityMemberList> createState() => _MyClubMemberState();
}

class _MyClubMemberState extends ConsumerState<CommunityMemberList> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
      final community = ref.watch(communityProvider);
      final creator= ref.watch(creatorProvider);
      if (community != null && creator!=null) {
        fetchCommunityMembers(ref, community.communityId, creator.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final members=ref.watch(communityMembersProvider);
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
      body:
          members.length > 0
              ? ListView.builder(
                itemCount: members.length,
                itemBuilder:
                    (context, index) =>
                        getListTile(members[index]),
              )
              : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
    );
  }
}


  Widget getListTile(CommunityMember user) {

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage:
              getUserImage(user.userPhoto), // Local image fallback
          onBackgroundImageError:
              (_, __) => const Icon(Icons.person, size: 30, color: Colors.grey),
        ),
        title: Text(
          "${user.userName}",
        ),
        trailing: Icon(Icons.more_vert, size: 25, color: Colors.black45),
      ),
    );
  }