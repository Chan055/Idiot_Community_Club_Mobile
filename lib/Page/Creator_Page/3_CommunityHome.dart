import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class CommunityHome extends StatefulWidget {
  const CommunityHome({super.key});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Stack(
                      children: [
                        Center(
                          child: ClipOval(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset("assets/images/RedPanda.jpeg"),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ButtonComponents.myGradientLogo(
                            Icons.edit_square,
                            logoSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ButtonComponents.getMyGradientText("MFU Community", 20.0),
                  InkWell(
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          "/communityMemberList",
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonComponents.getMyGradientText(
                          "Community Members",
                          10.0,
                        ),
                        ButtonComponents.getMyGradientText("123", 12.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    width: 318,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: Cardcomponent.cardBackDecoration,
                    child: SingleChildScrollView(
                      child: Text(
                        "Our community is a space, either online or offline, where book lovers connect to share their passion for reading. Members discuss books, exchange recommendations, write reviews, and engage in activities like book clubs, reading challenges, or author interactions. It fosters a sense of belonging and encourages a love for literature across diverse genres and perspectives.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: [
                      Cardcomponent.idiotClubCard(
                        clubName: "Tech Enthusiasts",
                        description:
                            "A community for tech lovers to share ideas, projects, and innovations.",
                      ),
                      Cardcomponent.idiotClubCard(
                        clubName: "Book Lovers Hub",
                        description:
                            "Join fellow bookworms in discussing literature, sharing reviews, and exploring new genres.",
                      ),
                      Cardcomponent.idiotClubCard(
                        clubName: "Fitness Warriors",
                        description:
                            "A place for fitness enthusiasts to motivate each other, share workouts, and track progress.",
                      ),
                      Cardcomponent.idiotClubCard(
                        clubName: "Gaming Legends",
                        description:
                            "Connect with gamers worldwide, discuss strategies, and participate in exciting tournaments.",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
