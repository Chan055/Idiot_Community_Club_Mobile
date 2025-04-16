import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Providers/Club/my_all_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';

class ClubHome extends ConsumerStatefulWidget {
  const ClubHome({super.key});

  @override
  ConsumerState<ClubHome> createState() => _ClubHomeState();
}

class _ClubHomeState extends ConsumerState<ClubHome> {
  @override
  void initState() {
    super.initState();
    final currentCommunity = ref.read(currentCommunityProvider);
    if (currentCommunity != null) {
      fetchMyClubs(ref, currentCommunity.communityId);
    }
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final currentCommunity = ref.read(currentCommunityProvider);
  // }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final clubs = ref.watch(clubListProvider);
    // final currentCommunity = ref.read(currentCommunityProvider);
    // fetchMyClubs(ref, currentCommunity!.communityId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Barcomponents.getIdiotSearchBar(text: "Search Club"),
          Expanded(
            child: ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, "/clubRequest",
                      arguments: club),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
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
