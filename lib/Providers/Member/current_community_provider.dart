import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Models/MyCommunityModel.dart';

final currentCommunityProvider =
    StateProvider<MyCommunityModel?>((ref) => null);
