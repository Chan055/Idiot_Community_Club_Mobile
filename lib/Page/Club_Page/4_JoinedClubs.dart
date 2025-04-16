import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Providers/Club/JoinedClubProvider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

class JoinedClub extends ConsumerStatefulWidget {
  const JoinedClub({super.key});

  @override
  ConsumerState<JoinedClub> createState() => _JoinedClubState();
}

class _JoinedClubState extends ConsumerState<JoinedClub> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final member = ref.read(memberProvider);
      final community = ref.read(currentCommunityProvider);

      if (member != null && community != null) {
        await fetchJoinedClubs(ref, member.id, community.communityId);
      }
    });
    if (mounted) {
      isLoading = false;
    }
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final joinedClubs = ref.watch(joinedClubsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Joined Club",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : joinedClubs.isEmpty
                  ? const Expanded(
                      child: Center(child: Text("No clubs joined.")),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: joinedClubs.length,
                        itemBuilder: (context, index) {
                          final club = joinedClubs[index];
                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              "/viewAnnouncement",
                              arguments: club,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45.0),
                              child: Cardcomponent.idiotClubCard1(
                                clubName: club.clubName,
                                description: club.clubDescription,
                                clubLogo: club.clubLogo,
                                totalMembers: club.totalMembers,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
