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
          // Barcomponents.idiotClubBar(screen, context),
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
