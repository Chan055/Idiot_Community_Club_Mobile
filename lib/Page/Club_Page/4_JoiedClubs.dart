import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class JoinedClub extends StatefulWidget {
  const JoinedClub({super.key});

  @override
  State<JoinedClub> createState() => _JoinedClubState();
}

class _JoinedClubState extends State<JoinedClub> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barcomponents.idiotClubBar(screen, context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: ButtonComponents.getMyGradientText("My Joined Club", 20),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, "/viewAnnouncement"),
                    child: Cardcomponent.idiotClubCard(
                      clubName: "Yoga Class",
                      description:
                          "A club for tech enthusiasts to discuss AI, software development, and the latest innovations in the industry.",
                    ),
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Bookworms Club",
                    description:
                        "A place for book lovers to share and discuss their favorite books, authors, and genres.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Barcomponents.getIdiotClubNav(screen, context),
    );
  }
}
