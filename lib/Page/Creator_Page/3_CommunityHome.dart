import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Providers/Creator/club_proivider.dart';
import 'package:idiot_community_club_app/Providers/Creator/community_provider.dart';
import '../../Components/BarComponents.dart';
import '../../Components/ButtonComponents.dart';
import '../../Components/CardComponents.dart';

class CommunityHome extends ConsumerStatefulWidget {
  const CommunityHome({super.key});

  @override
  ConsumerState<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends ConsumerState<CommunityHome> {
  @override
  void initState() {
    super.initState();
    final community = ref.read(communityProvider);
    if (community != null) {
      fetchClubs(ref, community.communityId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final community = ref.watch(communityProvider);
    final clubs = ref.watch(clubListProvider);
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: community == null
          ? const Center(child: Text("No Community Data"))
          : Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Stack(
                            children: [
                              Center(
                                child: ClipOval(
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    child:
                                        _buildCommunityImage(community.image),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: ButtonComponents.myGradientLogo(
                                  Icons.edit_square,
                                  logoSize: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ButtonComponents.getMyGradientText(
                            community.communityName, 20.0),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, "/communityMemberList"),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonComponents.getMyGradientText(
                                  "Community Members", 10.0),
                              ButtonComponents.getMyGradientText(
                                  "${community.clubCount}", 12.0),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 200,
                          width: 318,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: Cardcomponent.cardBackDecoration,
                          child: SingleChildScrollView(
                            child: Text(
                              community.description,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children: clubs
                              .map((club) => Cardcomponent.idiotClubCard1(
                                    clubName: club.clubName,
                                    description: club.clubDescription,
                                    clubLogo: club.clubLogo,
                                    totalMembers: club.totalMembers,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCommunityImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Image.asset("assets/images/UploadImage.png", fit: BoxFit.cover);
    } else if (imagePath.startsWith("http")) {
      return Image.network(imagePath, fit: BoxFit.cover);
    } else {
      return Image.file(File(imagePath), fit: BoxFit.cover);
    }
  }
}
