import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class MyCreatedClub extends StatefulWidget {
  const MyCreatedClub({super.key});

  @override
  State<MyCreatedClub> createState() => _MyCreatedClubState();
}

class _MyCreatedClubState extends State<MyCreatedClub> {
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
              Navigator.pushNamed(context, "/myClubAnouncement");
            },
            child: Cardcomponent.idiotClubCard(
              clubName: "It Club",
              description:
                  "A club for tech enthusiasts to discuss AI, software development, and the latest innovations in the industry.",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Barcomponents.getIdiotClubNav(screen, context),
    );
  }
}
