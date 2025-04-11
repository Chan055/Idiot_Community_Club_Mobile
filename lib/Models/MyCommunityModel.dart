class MyCommunityModel {
  final int communityId;
  final String communityName;
  final String description;
  final String image;
  final int memberCount;
  final int clubCount;

  MyCommunityModel({
    required this.communityId,
    required this.communityName,
    required this.description,
    required this.image,
    required this.memberCount,
    required this.clubCount,
  });

  factory MyCommunityModel.fromJson(Map<String, dynamic> json) {
    return MyCommunityModel(
      communityId: json['communityId'],
      communityName: json['communityName'],
      description: json['description'],
      image: json['image'],
      memberCount: json['memberCount'] ?? 3,
      clubCount: json['clubCount'] ?? 1,
    );
  }
}
