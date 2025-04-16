import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';

Future<void> fetchJoinedClubMembers(WidgetRef ref, int clubId) async {
  final url = Uri.parse('$BASE_URL/api/member/view-club-members/$clubId');
  final response = await http.get(url);

  final data = jsonDecode(response.body);
  if (data['success'] == true) {
    final List membersJson = data['data'];
    final members = membersJson.map((e) => ClubMember.fromJson(e)).toList();

    if (ref.context.mounted) {
      ref.read(joinedClubMembersProvider.notifier).state =
          List<ClubMember>.from(members);
    }

    // ref.read(joinedClubMembersProvider.notifier).state =
    //     List<ClubMember>.from(members);
  } else {
    print("${data['message']}");
    if (ref.context.mounted) {
      ref.read(joinedClubMembersProvider.notifier).state = [];
    }
    // ref.read(joinedClubMembersProvider.notifier).state = [];
  }
}

final joinedClubMembersProvider = StateProvider<List<ClubMember>>((ref) => []);

class ClubMember {
  final String userName;
  final int userId;
  final String? profileImage;

  ClubMember({
    required this.userName,
    required this.userId,
    this.profileImage,
  });

  factory ClubMember.fromJson(Map<String, dynamic> json) {
    return ClubMember(
      userName: json['userName'],
      userId: json['userId'],
      profileImage: json['profileImage'],
    );
  }
}
