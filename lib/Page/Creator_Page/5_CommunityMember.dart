import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ListTileRequst.dart';
import 'package:idiot_community_club_app/Models/User.dart';

class CommunityMember extends StatefulWidget {
  const CommunityMember({super.key});

  @override
  State<CommunityMember> createState() => _CommunityMemberState();
}

class _CommunityMemberState extends State<CommunityMember> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder:
                  (context, index) =>
                      ListTileComponent.getListTile(users[index], context),
            ),
          ),
        ],
      ),
    );
  }
}
