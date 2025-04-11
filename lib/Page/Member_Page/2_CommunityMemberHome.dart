import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Providers/Member/view_community_provider.dart';

class CommunityMemberHome extends ConsumerStatefulWidget {
  const CommunityMemberHome({super.key});

  @override
  ConsumerState<CommunityMemberHome> createState() =>
      _CommunityMemberHomeState();
}

class _CommunityMemberHomeState extends ConsumerState<CommunityMemberHome> {
  @override
  void initState() {
    super.initState();
    fetchViewCommunities(ref);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final viewCommunities = ref.watch(viewCommunityStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Barcomponents.getIdiotSearchBar(text: "Search Community"),
          Expanded(
            child: viewCommunities.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: viewCommunities.length,
                    itemBuilder: (context, index) {
                      final community = viewCommunities[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/comReqForm",
                          arguments: community,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Cardcomponent.idiotCommunityCard(
                              comName: community.name,
                              description: community.description,
                              comPhoto: (Uri.tryParse(community.image)
                                              ?.hasAbsolutePath ==
                                          true &&
                                      (community.image.startsWith("http") ||
                                          community.image.startsWith("https")))
                                  ? Image.network(community.image,
                                      fit: BoxFit.cover)
                                  : (community.image.startsWith("/"))
                                      ? Image.file(File(community.image),
                                          fit: BoxFit.cover)
                                      : Image.asset(
                                          "assets/images/IdiotLogo.png",
                                          fit: BoxFit.cover),
                              memberCount: 100),
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
