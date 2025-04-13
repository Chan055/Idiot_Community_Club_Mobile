


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';

enum RequestStatus { APPROVED, REJECTED }

String getStatusString(RequestStatus status) {
  return status.toString().split('.').last;
}

Future<void> sendNewClubJoinDecision({
  required int communityId,
  required int clubLeaderId,
  required int clubId,
  required int joinClubRequestId,
  required RequestStatus requestStatus,
  required BuildContext context,
}) async {
  final uri = Uri.parse("$BASE_URL/api/leader/decide-new-club-request");
  final body = jsonEncode({
    "communityId": communityId,
    "clubLeaderId": clubLeaderId,
    "clubId": clubId,
    "joinClubRequestId": joinClubRequestId,
    "requestStatus": getStatusString(requestStatus),
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


Future<void> fetchClubJoinRequests(WidgetRef ref, int clubId) async {
  final uri = Uri.parse("$BASE_URL/api/leader/view-club-join-request/$clubId");
  final response = await http.get(uri);

  final resBody = jsonDecode(response.body);
  if (resBody["success"] == true) {
    final List<dynamic> data = resBody["data"];
    final requests = data.map((e) => ClubJoinRequest.fromJson(e)).toList();
    ref.read(clubJoinRequestsProvider.notifier).state = List<ClubJoinRequest>.from(requests);
  } else {
    print("Error: ${resBody["message"]}");
    ref.read(clubJoinRequestsProvider.notifier).state = [];
  }
}


final clubJoinRequestsProvider = StateProvider<List<ClubJoinRequest>>((ref) => []);

class ClubJoinRequest {
  final int requestId;
  final String userName;
  final String? userImage;
  final String? reasonToJoin;

  ClubJoinRequest({
    required this.requestId,
    required this.userName,
    this.userImage,
    this.reasonToJoin,
  });

  factory ClubJoinRequest.fromJson(Map<String, dynamic> json) {
    return ClubJoinRequest(
      requestId: json['requestId'],
      userName: json['userName'],
      userImage: json['userImage'],
      reasonToJoin: json['reasonToJoin'],
    );
  }
}
