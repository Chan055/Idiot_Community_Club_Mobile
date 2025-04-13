import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Club/current_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

class MyCreatedClubModel {
  final String clubLogo;
  final String clubName;
  final String clubDescription;
  final int clubId;
  final int memberCount;

  MyCreatedClubModel({
    required this.clubLogo,
    required this.clubName,
    required this.clubDescription,
    required this.clubId,
    required this.memberCount,
  });

  factory MyCreatedClubModel.fromJson(Map<String, dynamic> json) {
    return MyCreatedClubModel(
      clubLogo: json['clubLogo'],
      clubName: json['clubName'],
      clubDescription: json['clubDescription'],
      clubId: json['clubId'],
      memberCount: json['memberCount'],
    );
  }
}

// Provider
final myCreatedClubStateProvider =
    StateProvider<MyCreatedClubModel?>((ref) => null);

Future<void> fetchMyCreatedClub(WidgetRef ref, leaderId, communityId) async {
  if (leaderId == null || communityId == null) {
    throw Exception("Missing parameters");
  }

  final uri = Uri.parse(
    '$BASE_URL/api/leader/view-my-club?leaderId=$leaderId&commuityId=$communityId',
  );

  final response = await http.get(uri);
  final body = jsonDecode(response.body);

  if (response.statusCode == 200 && body['success'] == true) {
    final club = MyCreatedClubModel.fromJson(body['data']);
    ref.read(myCreatedClubStateProvider.notifier).state = club;
  } else {
    throw Exception(body['message'] ?? 'Failed to fetch club');
  }
}
