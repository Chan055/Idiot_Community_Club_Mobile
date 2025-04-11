import 'package:flutter_riverpod/flutter_riverpod.dart';

final communityProvider = StateProvider<Community?>((ref)=> null) ;


class Community {
  final int communityId;
  final String communityName;
  final String description;
  final String image;
  final String createAt;
  final String creatorName;
  final String creatorEmail;
  final int communityInfoId;
  final int clubCount;

  Community({
    required this.communityId,
    required this.communityName,
    required this.description,
    required this.image,
    required this.createAt,
    required this.creatorName,
    required this.creatorEmail,
    required this.communityInfoId,
    required this.clubCount,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      communityId: json['communityId'],
      communityName: json['communityName'],
      description: json['description'],
      image: json['image'],
      createAt: json['createAt'],
      creatorName: json['creatorName'],
      creatorEmail: json['creatorEmail'],
      communityInfoId: json['communityInfoId'],
      clubCount: json['clubCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'communityName': communityName,
      'description': description,
      'image': image,
      'createAt': createAt,
      'creatorName': creatorName,
      'creatorEmail': creatorEmail,
      'communityInfoId': communityInfoId,
      'clubCount': clubCount,
    };
  }
}

