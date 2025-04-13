import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';

class ClubAnnouncement {
  final int postId;
  final String message;
  final DateTime createdAt;

  ClubAnnouncement({
    required this.postId,
    required this.message,
    required this.createdAt,
  });

  factory ClubAnnouncement.fromJson(Map<String, dynamic> json) {
    return ClubAnnouncement(
      postId: json['id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

final clubAnnouncementProvider =
    StateProvider<List<ClubAnnouncement>>((ref) => []);

Future<void> fetchAnnouncements(WidgetRef ref, int memberId, int clubId) async {
  final uri = Uri.parse("$BASE_URL/leader/view-own-post/$memberId/$clubId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final List<ClubAnnouncement> announcements = (data['data'] as List)
        .map((e) => ClubAnnouncement.fromJson(e))
        .toList();
    ref.read(clubAnnouncementProvider.notifier).state = announcements;
  } else {
    throw Exception(data["message"]);
  }
}

Future<void> postAnnouncement({
  required WidgetRef ref,
  required int leaderId,
  required int clubId,
  required int communityId,
  required String message,
}) async {
  final uri = Uri.parse("$BASE_URL/api/leader/make-post");
  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "leaderId": leaderId,
      "clubId": clubId,
      "communityId": communityId,
      "message": message,
    }),
  );

  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final newAnnouncement = ClubAnnouncement.fromJson(data['data']);
    final current = ref.read(clubAnnouncementProvider);
    ref.read(clubAnnouncementProvider.notifier).state = [
      ...current,
      newAnnouncement
    ];
  } else {
    throw Exception(data['message'] ?? 'Failed to post announcement');
  }
}
