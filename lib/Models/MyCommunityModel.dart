class MyCommunityModel {
  final int communityId;
  final String communityName;
  final String description;
  final String image;
  final int memberCount;
  final int clubCount;
  final bool isLeader;

  MyCommunityModel({
    required this.communityId,
    required this.communityName,
    required this.description,
    required this.image,
    required this.memberCount,
    required this.clubCount,
    required this.isLeader,
  });

  MyCommunityModel copyWith({
    int? communityId,
    String? communityName,
    String? description,
    String? image,
    int? memberCount,
    int? clubCount,
    bool? isLeader,
  }) {
    return MyCommunityModel(
      communityId: communityId ?? this.communityId,
      communityName: communityName ?? this.communityName,
      description: description ?? this.description,
      image: image ?? this.image,
      memberCount: memberCount ?? this.memberCount,
      clubCount: clubCount ?? this.clubCount,
      isLeader: isLeader ?? this.isLeader,
    );
  }

  factory MyCommunityModel.fromJson(Map<String, dynamic> json) {
    return MyCommunityModel(
        communityId: json['communityId'],
        communityName: json['communityName'],
        description: json['description'],
        image: json['image'],
        memberCount: json['memberCount'] ?? 3,
        clubCount: json['clubCount'] ?? 1,
        isLeader: json['isLeader'] ?? false);
  }
}
