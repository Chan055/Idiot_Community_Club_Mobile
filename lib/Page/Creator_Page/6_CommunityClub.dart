import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class CommunityClub extends StatefulWidget {
  const CommunityClub({super.key});

  @override
  State<CommunityClub> createState() => _CommunityclubState();
}

class _CommunityclubState extends State<CommunityClub> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Chess Club",
                    description:
                        "Sharpen your strategy and outthink your opponents!",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Photography Club",
                    description:
                        "Capture the world through your lens and master the art of photography.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Music Club",
                    description:
                        "Explore melodies, learn instruments, and jam with fellow music lovers.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Gaming Club",
                    description:
                        "Compete, collaborate, and connect over the latest video games.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Coding Club",
                    description:
                        "Build projects, solve challenges, and explore the world of programming.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Drama Club",
                    description:
                        "Unleash your creativity and bring stories to life on stage.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Robotics Club",
                    description:
                        "Design, build, and program robots to take on exciting challenges.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Science Club",
                    description:
                        "Conduct experiments and explore the wonders of science.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Art Club",
                    description:
                        "Express yourself through painting, sketching, and digital art.",
                  ),
                  Cardcomponent.idiotClubRequestCart(
                    context: context,
                    clubName: "Book Club",
                    description:
                        "Read, discuss, and share your favorite books with fellow literature lovers.",
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
