import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


Future<void> fetchClubs(WidgetRef ref, int communityId) async {
  final uri = Uri.parse("http://localhost:8080/api/creator/view-clubs?communityId=$communityId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final List<Club> clubs = (data['data'] as List)
        .map((club) => Club.fromJson(club))
        .toList();
    ref.read(clubListProvider.notifier).state = clubs;
  }
}

final clubListProvider = StateProvider<List<Club>>((ref) => []);

class Club {
  final int clubId;
  final String clubName;
  final String clubDescription;
  final String clubLogo;
  final int totalMembers;

  Club({
    required this.clubId,
    required this.clubName,
    required this.clubDescription,
    required this.clubLogo,
    required this.totalMembers,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubDescription: json['clubDescription'],
      clubLogo: json['clubLogo'],
      totalMembers: json['totalMembers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clubId': clubId,
      'clubName': clubName,
      'clubDescription': clubDescription,
      'clubLogo': clubLogo,
      'totalMembers': totalMembers,
    };
  }
}
