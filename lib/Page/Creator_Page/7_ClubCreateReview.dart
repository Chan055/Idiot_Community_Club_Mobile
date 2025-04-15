import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Components/TextComponents.dart';
import 'package:idiot_community_club_app/Helper/MyImagePicker.dart';
import 'package:idiot_community_club_app/Providers/Creator/community_provider.dart';
import 'package:idiot_community_club_app/Providers/Creator/creator_provider.dart';
import 'package:idiot_community_club_app/Providers/Creator/new_club_requests_provider.dart';

class ClubCreateReview extends ConsumerWidget {
  const ClubCreateReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newClub =
        ModalRoute.of(context)!.settings.arguments as NewClubRequest;
    final creator = ref.watch(creatorProvider);
    final community = ref.watch(communityProvider);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: myGradient()),
            child: SafeArea(
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Cardcomponent.getMyOwnGradientBox(
            height: 590,
            width: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Textcomponents.whiteText(
                        fontSize: 18,
                        text: newClub.clubName,
                        fontweight: FontWeight.bold,
                      ),
                      SizedBox(height: 5),
                      ClipOval(
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.white,
                          child: buildClubImage(newClub.logo),
                        ),
                      ),
                    ],
                  ),
                ),
                Textcomponents.whiteText(
                  text: "Club Leader Name:",
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
                Cardcomponent.descriptionBox(
                  text: newClub.clubLeaderName,
                  height: 35,
                  width: 320,
                  fontSize: 16,
                ),
                Textcomponents.whiteText(
                  text: "Description:",
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
                Cardcomponent.descriptionBox(
                  text: newClub.description,
                  height: 140,
                  width: 320,
                  fontSize: 16,
                ),
                Textcomponents.whiteText(
                  text: "Reason:",
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
                Cardcomponent.descriptionBox(
                  text: newClub.reason,
                  height: 140,
                  width: 320,
                  fontSize: 16,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (creator != null && community != null) {
                      await sendClubDecision(
                        creatorId: creator.id,
                        communityId: community.communityId,
                        createClubRequestId: newClub.requestId,
                        status: RequestStatus.APPROVED,
                        context: context,
                      );
                      fetchNewClubRequests(ref, community.communityId);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: ButtonComponents.acceptButton(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Textcomponents.whiteText(
                        text: "Accept",
                        fontSize: 16,
                        fontweight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (creator != null && community != null) {
                      await sendClubDecision(
                        creatorId: creator.id,
                        communityId: community.communityId,
                        createClubRequestId: newClub.requestId,
                        status: RequestStatus.REJECTED,
                        context: context,
                      );
                      fetchNewClubRequests(ref, community.communityId);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: ButtonComponents.rejectButton(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Textcomponents.whiteText(
                        text: "Reject",
                        fontSize: 16,
                        fontweight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
