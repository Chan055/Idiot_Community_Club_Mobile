import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';

final viewCommunityStateProvider =
    StateProvider<List<ViewCommunity>>((ref) => []);

Future<void> fetchViewCommunities(WidgetRef ref) async {
  final uri = Uri.parse('$BASE_URL/api/member/view-all-communities');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final resBody = jsonDecode(response.body);
    if (resBody['success'] == true) {
      List<dynamic> rawList = resBody['data'];
      final communities =
          rawList.map((e) => ViewCommunity.fromJson(e)).toList();
      ref.read(viewCommunityStateProvider.notifier).state = communities;
    } else {
      throw Exception(resBody['message'] ?? 'API returned false success');
    }
  } else {
    throw Exception('Failed to fetch communities');
  }
}

class ViewCommunity {
  final int id;
  final String name;
  final String description;
  final String image;

  ViewCommunity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory ViewCommunity.fromJson(Map<String, dynamic> json) {
    return ViewCommunity(
      id: json['communityId'],
      name: json['communityName'],
      description: json['description'],
      image: json['image'],
    );
  }
}
