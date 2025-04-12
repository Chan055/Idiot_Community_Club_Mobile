import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentClubProvider = StateProvider<Club?>((ref) => null);

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
