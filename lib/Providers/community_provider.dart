import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';

// final communityListProvider = FutureProvider<List<Community>>((ref) async {
//   final uri = Uri.parse('$BASE_URL/api/member/view-all-communities');
//   final response = await http.get(uri);

//   if (response.statusCode == 200) {
//     final resBody = jsonDecode(response.body);
//     if (resBody['success'] == true) {
//       List<dynamic> rawList = resBody['data'];
//       return rawList.map((e) => Community.fromJson(e)).toList();
//     } else {
//       throw Exception(resBody['message']);
//     }
//   } else {
//     throw Exception('Failed to fetch communities');
//   }
// });

final communityProvider =
    StateNotifierProvider<CommunityNotifier, List<Community>>((ref) {
  return CommunityNotifier();
});

class CommunityNotifier extends StateNotifier<List<Community>> {
  CommunityNotifier() : super([]);

  void addCommunity(Community community) {
    state = [...state, community];
  }

  void clearCommunities() {
    state = [];
  }
}

class Community {
  final int id;
  final String name;
  final String description;
  final String image;
  final int clubCount;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.clubCount,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['communityId'],
      name: json['communityName'],
      description: json['description'],
      image: json['image'],
      clubCount: json['clubCount'],
    );
  }
}
