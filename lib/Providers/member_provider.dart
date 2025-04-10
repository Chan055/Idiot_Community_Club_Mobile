import 'package:flutter_riverpod/flutter_riverpod.dart';

// Member model
class Member {
  final int id;
  final String name;
  final String email;
  final String? photo;

  Member({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      photo: json['profileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photo": photo,
    };
  }
}

// Member Provider
final memberProvider = StateProvider<Member?>((ref) => null);
