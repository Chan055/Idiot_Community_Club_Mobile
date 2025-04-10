import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class MyClub extends StatefulWidget {
  const MyClub({super.key});

  @override
  State<MyClub> createState() => _MyClubState();
}

class _MyClubState extends State<MyClub> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Barcomponents.idiotClubBar(screen, context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: ButtonComponents.getMyGradientText("My Club", 20),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/myClubForm");
            },
            child: Stack(
              children: [
                Cardcomponent.getMyOwnGradientBox(
                  height: 200,
                  width: 320,
                  child: null,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: 190,
                  width: 310,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: ButtonComponents.myGradientLogo(
                    Icons.add_circle_outline,
                    logoSize: 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Barcomponents.getIdiotClubNav(screen, context),
    );
  }
}
