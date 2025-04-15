class MyCommunityModel {
  final int communityId;
  final String communityName;
  final String description;
  final String image;
  final bool isLeader;

  MyCommunityModel({
    required this.communityId,
    required this.communityName,
    required this.description,
    required this.image,
    required this.isLeader,
  });

  MyCommunityModel copyWith({
    int? communityId,
    String? communityName,
    String? description,
    String? image,
    bool? isLeader,
  }) {
    return MyCommunityModel(
      communityId: communityId ?? this.communityId,
      communityName: communityName ?? this.communityName,
      description: description ?? this.description,
      image: image ?? this.image,
      isLeader: isLeader ?? this.isLeader,
    );
  }

  factory MyCommunityModel.fromJson(Map<String, dynamic> json) {
    return MyCommunityModel(
        communityId: json['communityId'],
        communityName: json['communityName'],
        description: json['description'],
        image: json['image'],
        isLeader: json['isLeader'] ?? false);
  }
}
