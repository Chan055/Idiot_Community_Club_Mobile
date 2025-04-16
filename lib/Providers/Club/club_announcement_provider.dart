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
      postId: json['postId'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

final clubAnnouncementProvider =
    FutureProvider.family<List<ClubAnnouncement>, (int, int)>(
        (ref, tuple) async {
  final leaderId = tuple.$1;
  final clubId = tuple.$2;

  final uri = Uri.parse("$BASE_URL/api/leader/view-own-post/$leaderId/$clubId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);
  // print(data);

  if (data['success'] == true) {
    final List<ClubAnnouncement> announcements = (data['data'] as List)
        .map((e) => ClubAnnouncement.fromJson(e))
        .toList();
    return announcements;
  } else {
    // print("leaderId: $leaderId, clubId: $clubId");
    throw Exception(data["message"]);
  }
});

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

  if (data['success'] != true) {
    throw Exception(data['message'] ?? 'Failed to post announcement');
  }

  // Optionally refresh the provider after posting
  ref.invalidate(clubAnnouncementProvider((leaderId, clubId)));
}
