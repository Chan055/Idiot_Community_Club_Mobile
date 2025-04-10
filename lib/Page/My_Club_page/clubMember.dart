import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ListTileRequst.dart';
import 'package:idiot_community_club_app/Helper/Api.dart';
import 'package:idiot_community_club_app/Models/RandomUser.dart';

class MyClubMember extends StatefulWidget {
  const MyClubMember({super.key});

  @override
  State<MyClubMember> createState() => _MyClubMemberState();
}

class _MyClubMemberState extends State<MyClubMember> {
  List<RandomUser> userList = [];

  loadUser() async {
    List<RandomUser> listUser = await Api.getAllUser();
    setState(() {
      this.userList = listUser;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 0,
          ), // Optional padding for aesthetics
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Navigate back
            },
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensure Row takes only necessary space
              children: [const Icon(Icons.arrow_back, color: Colors.white)],
            ),
          ),
        ),
        title: Text("Club Members", style: TextStyle(color: Colors.white)),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body:
          userList.length > 0
              ? ListView.builder(
                itemCount: userList.length,
                itemBuilder:
                    (context, index) =>
                        ListTileComponent.getListTile_1(userList[index]),
              )
              : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
    );
  }
}
