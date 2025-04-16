import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';

Future<void> fetchClubMembers(WidgetRef ref, int leaderId, int clubId) async {
  final url =
      Uri.parse('$BASE_URL/api/leader/view-club-members/$leaderId/$clubId');
  final response = await http.get(url);

  final data = jsonDecode(response.body);
  if (data['success'] == true) {
    final List membersJson = data['data'];
    final members = membersJson.map((e) => ClubMember.fromJson(e)).toList();

    if (ref.context.mounted) {
      ref.read(clubMembersProvider.notifier).state =
          List<ClubMember>.from(members);
    }
    // ref.read(clubMembersProvider.notifier).state =
    //     List<ClubMember>.from(members);
  } else {
    print("${data['message']}");
    if (ref.context.mounted) {
      ref.read(clubMembersProvider.notifier).state = [];
    }
    // ref.read(clubMembersProvider.notifier).state = [];
  }
}

final clubMembersProvider = StateProvider<List<ClubMember>>((ref) => []);

class ClubMember {
  final String role;
  final String userName;
  final int userId;
  final String? profileImage;

  ClubMember({
    required this.role,
    required this.userName,
    required this.userId,
    this.profileImage,
  });

  factory ClubMember.fromJson(Map<String, dynamic> json) {
    return ClubMember(
      role: json['role'],
      userName: json['userName'],
      userId: json['userId'],
      profileImage: json['profileImage'],
    );
  }
}
