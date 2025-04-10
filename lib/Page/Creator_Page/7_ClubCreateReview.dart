import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Components/TextComponents.dart';

class ClubCreateReview extends StatefulWidget {
  const ClubCreateReview({super.key});

  @override
  State<ClubCreateReview> createState() => _ClubCreateReviewState();
}

class _ClubCreateReviewState extends State<ClubCreateReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: myGradient()),
            child: SafeArea(
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Cardcomponent.getMyOwnGradientBox(
            height: 590,
            width: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Textcomponents.whiteText(
                        fontSize: 18,
                        text: "Chess Class",
                        fontweight: FontWeight.bold,
                      ),
                      // Text(
                      //   "Chess Class",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(height: 5),
                      ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset("assets/images/RedPanda.jpeg"),
                        ),
                      ),
                    ],
                  ),
                ),
                Textcomponents.whiteText(
                  text: "Club Leader Name:",
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
                Cardcomponent.descriptionBox(
                  text: "Aike Paung Bra",
                  height: 35,
                  width: 320,
                  fontSize: 16,
                ),
                Textcomponents.whiteText(
                  text: "Description:",
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
                Cardcomponent.descriptionBox(
                  text:
                      "AikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAike Paung Bra",
                  height: 140,
                  width: 320,
                  fontSize: 16,
                ),
                Textcomponents.whiteText(
                  text: "Reason:",
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                ),
                Cardcomponent.descriptionBox(
                  text:
                      "AikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAikeAike Paung Bra",
                  height: 140,
                  width: 320,
                  fontSize: 16,
                ),
                Textcomponents.whiteText(
                  text: "11:30",
                  fontSize: 14,
                  fontweight: FontWeight.normal,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: ButtonComponents.acceptButton(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Textcomponents.whiteText(
                      text: "Accept",
                      fontSize: 16,
                      fontweight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: ButtonComponents.rejectButton(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Textcomponents.whiteText(
                      text: "Reject",
                      fontSize: 16,
                      fontweight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
