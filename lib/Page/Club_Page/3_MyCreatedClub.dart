import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Providers/Club/current_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Club/my_created_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

class MyCreatedClub extends ConsumerStatefulWidget {
  const MyCreatedClub({super.key});

  @override
  ConsumerState<MyCreatedClub> createState() => _MyCreatedClubState();
}

class _MyCreatedClubState extends ConsumerState<MyCreatedClub> {
  bool _isFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final leaderId = ref.read(memberProvider)?.id;
    final communityId = ref.read(currentCommunityProvider)?.communityId;

    if (!_isFetched) {
      fetchMyCreatedClub(ref, leaderId, communityId);
      _isFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final club = ref.watch(myCreatedClubStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: club == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ButtonComponents.getMyGradientText("My Club", 20),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    ref.read(myCreatedClubStateProvider.notifier).state = club;
                    Navigator.pushNamed(context, "/myClubAnouncement");
                  },
                  child: Cardcomponent.idiotClubCard1(
                    clubName: club.clubName,
                    description: club.clubDescription,
                    clubLogo: club.clubLogo,
                    totalMembers: club.memberCount,
                  ),
                ),
              ],
            ),
    );
  }
}
