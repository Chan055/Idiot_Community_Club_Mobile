// Model
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';

class CommunityMember {
  final String userName;
  final int userId;
  final String? userPhoto;

  CommunityMember({
    required this.userName,
    required this.userId,
    this.userPhoto,
  });

  factory CommunityMember.fromJson(Map<String, dynamic> json) {
    return CommunityMember(
      userName: json['userName'],
      userId: json['userId'],
      userPhoto: json['userPhoto'],
    );
  }
}

// Provider
final communityMembersProvider = StateProvider<List<CommunityMember>>((ref) => []);

// Fetch function
Future<void> fetchCommunityMembers(WidgetRef ref, int communityId, int creatorId) async {
  final url = Uri.parse(
    '$BASE_URL/api/creator/view-all-member-list?communityId=$communityId&creatorId=$creatorId',
  );
  final response = await http.get(url);
  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final List membersJson = data['data'];
    final members = membersJson.map((e) => CommunityMember.fromJson(e)).toList();
    ref.read(communityMembersProvider.notifier).state = List<CommunityMember>.from(members);
  } else {
    ref.read(communityMembersProvider.notifier).state = [];
  }
}
