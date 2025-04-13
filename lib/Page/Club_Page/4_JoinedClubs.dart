import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

// 1. Model
class JoinedClubModel {
  final int clubId;
  final String clubName;
  final String clubLogo;
  final String clubDescription;
  final int totalMembers;

  JoinedClubModel({
    required this.clubId,
    required this.clubName,
    required this.clubLogo,
    required this.clubDescription,
    required this.totalMembers,
  });

  factory JoinedClubModel.fromJson(Map<String, dynamic> json) {
    return JoinedClubModel(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubLogo: json['clubLogo'],
      clubDescription: json['clubDescription'],
      totalMembers: json['totalMembers'],
    );
  }
}

// 2. Provider
final joinedClubProvider =
    FutureProvider.family<List<JoinedClubModel>, (int, int)>(
        (ref, tuple) async {
  final userId = tuple.$1;
  final communityId = tuple.$2;

  final response = await http.get(Uri.parse(
    "$BASE_URL/api/member/view-joined-clubs?userId=$userId&communityId=$communityId",
  ));

  final data = jsonDecode(response.body);
  print("$userId,$communityId");
  print(data);
  if (data['success'] == true) {
    final List list = data['data'];
    return list.map((e) => JoinedClubModel.fromJson(e)).toList();
  } else {
    print("$userId,$communityId");
    throw Exception(data['message'] ?? 'Failed to load joined clubs');
  }
});

// 3. UI
class JoinedClub extends ConsumerWidget {
  const JoinedClub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberProvider);
    final community = ref.watch(currentCommunityProvider);

    final userId = member!.id; // replace with dynamic from provider
    final communityId =
        community!.communityId; // replace with dynamic from provider

    final asyncClubs = ref.watch(joinedClubProvider((userId, communityId)));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "My Joined Club",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: asyncClubs.when(
              data: (clubs) {
                return ListView.builder(
                  itemCount: clubs.length,
                  itemBuilder: (context, index) {
                    final club = clubs[index];
                    return InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, "/viewAnnouncement"),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45.0),
                          child: Cardcomponent.idiotClubCard1(
                            clubName: club.clubName,
                            description: club.clubDescription,
                            clubLogo: club.clubLogo,
                            totalMembers: club.totalMembers,
                          ),
                        ));
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Center(child: Text("$err"))),
            ),
          ),
        ],
      ),
    );
  }
}
