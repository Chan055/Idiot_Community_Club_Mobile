import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/MyCommunityModel.dart';
import '../Models/Constant.dart';

Future<void> fetchMyCommunity(WidgetRef ref, int memberId) async {
  final uri = Uri.parse("$BASE_URL/api/member/view-my-community/$memberId");
  final response = await http.get(uri);
  final data = jsonDecode(response.body);

  if (data['success'] == true) {
    final List<MyCommunityModel> myCommunities = (data['data'] as List)
        .map((club) => MyCommunityModel.fromJson(club))
        .toList();
    ref.read(myCommunityListProvider.notifier).state = myCommunities;
  }
}

final myCommunityListProvider =
    StateProvider<List<MyCommunityModel>>((ref) => []);
