import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

// Add this to your project (maybe under services/ or utils/ directory)
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum RequestStatus { APPROVED, REJECTED }

String getStatusString(RequestStatus status) {
  return status.toString().split('.').last;
}

Future<void> sendJoinRequestDecision({
  required RequestStatus status,
  required int joinCommunityRequestId,
  required int userId,
  required int communityCreatorId,
  required int communityId,
  required BuildContext context,
}) async {
  final uri =
      Uri.parse("http://localhost:8080/api/creator/decidejoincomreqeust");
  final body = jsonEncode({
    "requestStatus": getStatusString(status),
    "joinCommunityRequestId": joinCommunityRequestId,
    "userId": userId,
    "communityCreatorId": communityCreatorId,
    "communityId": communityId,
  });

  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  final data = jsonDecode(response.body);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(data["message"] ?? "Unknown response")),
  );
}

Future<void> fetchJoinRequests(WidgetRef ref, int communityId) async {
  final uri = Uri.parse(
      'http://localhost:8080/api/creator/view-join-request?communityId=$communityId');
  final response = await http.get(uri);

  final resBody = jsonDecode(response.body);
  if (resBody['success'] == true) {
    final List<dynamic> data = resBody['data'];
    final requests = data.map((item) => JoinRequest.fromJson(item)).toList();
    ref.read(joinRequestProvider.notifier).state =
        List<JoinRequest>.from(requests);
  } else {
    // Optionally handle errors
    print("Error: ${resBody["message"]}");
    ref.read(joinRequestProvider.notifier).state = [];
  }
}

final joinRequestProvider = StateProvider<List<JoinRequest>>((ref) => []);

class JoinRequest {
  final int joinRequestId; // <- add this
  final int userId;
  final String userName;
  final String? userPhoto;

  JoinRequest({
    required this.joinRequestId,
    required this.userId,
    required this.userName,
    this.userPhoto,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    return JoinRequest(
      joinRequestId: json['joinCommunityRequestId'],
      userId: json['userId'],
      userName: json['userName'],
      userPhoto: json['userPhoto'],
    );
  }
}
