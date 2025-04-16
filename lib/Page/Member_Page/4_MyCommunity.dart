import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/my_community_list_provider.dart';

class MyCommunity extends ConsumerStatefulWidget {
  const MyCommunity({super.key});

  @override
  ConsumerState<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends ConsumerState<MyCommunity> {
  @override
  void initState() {
    super.initState();
    final member = ref.read(memberProvider);
    //Add ref here
    if (member != null && ref.context.mounted) {
      fetchMyCommunity(ref, member.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final communityList = ref.watch(myCommunityListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: ButtonComponents.getMyGradientText("My Community", 20),
          ),
          Expanded(
            child: communityList.isEmpty
                ? const Center(child: Text("❌ No Community Found"))
                : SingleChildScrollView(
                    child: Column(
                      children: communityList.map((community) {
                        // Widget comPhotoWidget;
                        // if (Uri.tryParse(community.image)?.hasAbsolutePath ==
                        //         true &&
                        //     (community.image.startsWith("http") ||
                        //         community.image.startsWith("https"))) {
                        //   comPhotoWidget =
                        //       Image.network(community.image, fit: BoxFit.cover);
                        // } else if (community.image.startsWith("/")) {
                        //   comPhotoWidget = Image.file(File(community.image),
                        //       fit: BoxFit.cover);
                        // } else {
                        //   comPhotoWidget = Image.asset(
                        //       "assets/images/IdiotLogo.png",
                        //       fit: BoxFit.cover);
                        // }

                        return InkWell(
                          onTap: () {
                            ref.read(currentCommunityProvider.notifier).state =
                                community;
                            Navigator.pushNamed(context, "/clubMain",
                                arguments: community.communityId);
                          },
                          child: Cardcomponent.idiotCommunityCard(
                            comName: community.communityName,
                            description: community.description,
                            comPhoto: community.image,
                            comId: community.communityId,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
