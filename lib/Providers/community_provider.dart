import 'package:flutter_riverpod/flutter_riverpod.dart';

final communityProvider = StateNotifierProvider<CommunityNotifier, List<Community>>((ref) {
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
