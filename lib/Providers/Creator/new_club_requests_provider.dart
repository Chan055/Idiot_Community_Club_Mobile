import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:idiot_community_club_app/Models/Constant.dart';

enum RequestStatus { APPROVED, REJECTED }

String getStatusString(RequestStatus status) {
  return status.toString().split('.').last;
}

Future<void> sendClubDecision({
  required int creatorId,
  required int communityId,
  required int createClubRequestId,
  required RequestStatus status,
  required BuildContext context,
}) async {
  final uri = Uri.parse("$BASE_URL/api/creator/decide-new-club-request");
  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "creatorId": creatorId,
      "communityId": communityId,
      "createClubRequestId": createClubRequestId,
      "requestStatus": getStatusString(status),
    }),
  );

  final resBody = jsonDecode(response.body);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(resBody['message'] ?? 'Unknown response')),
  );
}

Future<void> fetchNewClubRequests(WidgetRef ref, int communityId) async {
  final uri = Uri.parse(
      "$BASE_URL/api/creator/view-all-new-club-request?communityId=$communityId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final List<NewClubRequest> requests = (data['data'] as List)
        .map((item) => NewClubRequest.fromJson(item))
        .toList();

    if (ref.context.mounted) {
      ref.read(newClubRequestProvider.notifier).state = requests;
    }
    // ref.read(newClubRequestProvider.notifier).state = requests;
  } else {
    print("Error: ${data["message"]}");
    if (ref.context.mounted) {
      ref.read(newClubRequestProvider.notifier).state = [];
    }
    // ref.read(newClubRequestProvider.notifier).state = [];
  }
}

final newClubRequestProvider = StateProvider<List<NewClubRequest>>((ref) => []);

class NewClubRequest {
  final int requestId;
  final String clubName;
  final String description;
  final String logo;
  final String reason;
  final String clubLeaderName;

  NewClubRequest({
    required this.requestId,
    required this.clubName,
    required this.description,
    required this.logo,
    required this.reason,
    required this.clubLeaderName,
  });

  factory NewClubRequest.fromJson(Map<String, dynamic> json) {
    return NewClubRequest(
      requestId: json['requestId'],
      clubName: json['clubName'],
      description: json['description'],
      logo: json['logo'],
      reason: json['reason'],
      clubLeaderName: json['clubLeaderName'],
    );
  }
}
