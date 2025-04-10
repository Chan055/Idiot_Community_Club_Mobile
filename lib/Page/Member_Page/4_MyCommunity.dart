import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class MyCommunity extends StatefulWidget {
  const MyCommunity({super.key});

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
  @override
  void initState() {
    // TODO: implement initState
    Barcomponents.selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Barcomponents.idiotBar(screen),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: ButtonComponents.getMyGradientText("My Community", 20),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/clubHome"),
                    child: Cardcomponent.idiotCommunityCard(
                      clubName: "MFU Community",
                      description:
                          "A club for tech enthusiasts to discuss AI, software development, and the latest innovations in the industry.",
                    ),
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Bookworms Hub",
                    description:
                        "A place for book lovers to share and discuss their favorite books, authors, and genres.",
                  ),
                  Cardcomponent.idiotCommunityCard(
                    clubName: "Fitness Warriors",
                    description:
                        "A club dedicated to health and fitness, where members share workout routines, diet plans, and motivation.",
                  ),
                  Cardcomponent.idiotClubCard(
                    clubName: "Gaming Legends",
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
      bottomNavigationBar: Barcomponents.getIdiotCommunityNav(screen, context),
    );
  }
}
