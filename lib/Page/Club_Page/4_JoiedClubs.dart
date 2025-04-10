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
          Barcomponents.idiotClubBar(screen, context),
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
                    onTap:
                        () => Navigator.pushNamed(context, "/viewAnnouncement"),
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
                  Cardcomponent.idiotClubCard(
                    clubName: "Fitness Class",
                    description:
                        "A club dedicated to health and fitness, where members share workout routines, diet plans, and motivation.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Gaming Club",
                    description:
                        "Join us for exciting game nights, discussions about the latest gaming trends, and esports tournaments.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Photography Club",
                    description:
                        "A creative space for photographers of all levels to share their work, learn new techniques, and collaborate.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Artists Club",
                    description:
                        "A club for food lovers and aspiring chefs to exchange recipes, cooking tips, and explore different cuisines.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Basketball Club",
                    description:
                        "A community of adventurers sharing travel experiences, tips, and destination guides.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Music Lovers",
                    description:
                        "Whether you're a musician or just a fan, this club is for sharing music, discovering new artists, and discussing trends.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Anime & Manga Fanatics",
                    description:
                        "A club for anime and manga lovers to discuss series, share recommendations, and explore Japanese pop culture.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Entrepreneurs Network",
                    description:
                        "A space for aspiring and established entrepreneurs to network, share business ideas, and support each other.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Barcomponents.getIdiotClubNav(screen, context),
    );
  }
}
