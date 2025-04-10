import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/RandomUser.dart';

const USER_API = "https://randomuser.me/api/?results=50";

class Api {
  static Future<List<RandomUser>> getAllUser() async {
    var responData = await http.get(Uri.parse(USER_API));
    var responseBody = jsonDecode(responData.body);
    List<dynamic> lisy = responseBody['results'] as List;
    List<RandomUser> userList = lisy.map((e) => RandomUser.from(e)).toList();
    return userList;
  }
}
