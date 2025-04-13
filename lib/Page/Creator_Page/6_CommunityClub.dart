import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Providers/Creator/community_provider.dart';
import 'package:idiot_community_club_app/Providers/Creator/new_club_requests_provider.dart';

class CommunityClub extends ConsumerStatefulWidget {
  const CommunityClub({super.key});

  @override
  ConsumerState<CommunityClub> createState() => _CommunityclubState();
}

class _CommunityclubState extends ConsumerState<CommunityClub> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final community = ref.read(communityProvider);
      if (community != null) {
        fetchNewClubRequests(ref, community.communityId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newClubs = ref.watch(newClubRequestProvider);

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: newClubs.isEmpty
                ? const Center(child: Text("No new club requests"))
                : Column(
                    children: newClubs
                        .map(
                          (newClub) => Cardcomponent.idiotClubRequestCart1(
                            context: context,
                            club: newClub,
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
