import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class ClubHome extends StatefulWidget {
  const ClubHome({super.key});

  @override
  State<ClubHome> createState() => _ClubHomeState();
}

class _ClubHomeState extends State<ClubHome> {
  @override
  void initState() {
    // TODO: implement initState

    Barcomponents.selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Barcomponents.idiotClubBar(screen, context),
          Barcomponents.getIdiotSearchBar(text: "Search Club"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/clubRequest"),
                    child: Cardcomponent.idiotClubCard(
                      clubName: "Chess Club",
                      description:
                          "A club for tech enthusiasts to discuss AI, software development, and the latest innovations in the industry.",
                    ),
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Football Club ",
                    description:
                        "A place for book lovers to share and discuss their favorite books, authors, and genres.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Fitness Club",
                    description:
                        "A club dedicated to health and fitness, where members share workout routines, diet plans, and motivation.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Gaming Club",
                    description:
                        "Join us for exciting game nights, discussions about the latest gaming trends, and esports tournaments.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Photography Enthusiasts",
                    description:
                        "A creative space for photographers of all levels to share their work, learn new techniques, and collaborate.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Culinary Artists",
                    description:
                        "A club for food lovers and aspiring chefs to exchange recipes, cooking tips, and explore different cuisines.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Travel Explorers",
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
