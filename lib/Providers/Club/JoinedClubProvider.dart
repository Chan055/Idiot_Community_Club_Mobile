import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Club/current_club_provider.dart';

Future<void> fetchJoinedClubs(
    WidgetRef ref, int userId, int communityId) async {
  final uri = Uri.parse(
    "$BASE_URL/api/member/view-joined-clubs?userId=$userId&communityId=$communityId",
  );
  print("This is$userId");
  print("This is $communityId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final List<Club> clubs = (data['data'] as List)
        .map((clubJson) => Club.fromJson(clubJson))
        .toList();
    if (ref.context.mounted) {
      ref.read(joinedClubsProvider.notifier).state = clubs;
    }
  } else {
    print("This is error");
    if (ref.context.mounted) {
      ref.read(joinedClubsProvider.notifier).state = [];
    }
  }
}

final joinedClubsProvider = StateProvider<List<Club>>((ref) => []);

// class JoinedClub {
//   final int clubId;
//   final String clubName;
//   final String clubDescription;
//   final String clubLogo;
//   final int totalMembers;

//   JoinedClub({
//     required this.clubId,
//     required this.clubName,
//     required this.clubDescription,
//     required this.clubLogo,
//     required this.totalMembers,
//   });

//   factory JoinedClub.fromJson(Map<String, dynamic> json) {
//     return JoinedClub(
//       clubId: json['clubId'],
//       clubName: json['clubName'],
//       clubDescription: json['clubDescription'],
//       clubLogo: json['clubLogo'],
//       totalMembers: json['totalMembers'],
//     );
//   }
// }
