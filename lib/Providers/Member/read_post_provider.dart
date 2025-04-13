import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';

class ClubPost {
  final int postId;
  final String message;
  final DateTime createdAt;

  ClubPost({
    required this.postId,
    required this.message,
    required this.createdAt,
  });

  factory ClubPost.fromJson(Map<String, dynamic> json) {
    return ClubPost(
      postId: json['id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

final clubPostsProvider =
    FutureProvider.family<List<ClubPost>, (int, int)>((ref, tuple) async {
  final clubId = tuple.$1;
  final communityId = tuple.$2;

  final uri = Uri.parse(
      "$BASE_URL/api/member/club/read-posts?clubId=$clubId&communityId=$communityId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);
  print(data);

  if (data['success'] == true) {
    return (data['data'] as List).map((e) => ClubPost.fromJson(e)).toList();
  } else {
    throw Exception(data["message"] ?? "Failed to fetch posts");
  }
});
