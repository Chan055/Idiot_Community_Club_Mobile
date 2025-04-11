import 'package:flutter_riverpod/flutter_riverpod.dart';

final creatorProvider = StateProvider<Creator?>((ref) => null);

class Creator {
  final int id;
  final String name;
  final String email;
  final String? photo;
  final bool hasCommunity;

  Creator({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
    required this.hasCommunity,
  });

  Creator copyWith({String? name, String? email, String? photo, bool? hasCommunity}) {
    return Creator(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      hasCommunity: hasCommunity ?? this.hasCommunity,
    );
  }

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json["communityCreatorId"],
      name: json["creatorName"],
      email: json["creatorEmail"],
      photo: json["creatorPhoto"],
      hasCommunity: json["hasCommunity"]?? false,
    );
  }
}


