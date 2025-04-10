import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/TextComponents.dart';

class Cardcomponent {
  static BoxDecoration cardBackDecoration = BoxDecoration(
    gradient: ButtonComponents.myGradient,
    borderRadius: BorderRadius.all(Radius.circular(18)),
  );
  static BoxDecoration cardDescriptionDecoration = BoxDecoration(
    color: const Color.fromARGB(50, 0, 0, 0),
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static TextStyle clubTitleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Colors.white,
    letterSpacing: 0,
  );

  static Container getMyOwnGradientBox({
    required double height,
    required double width,
    required child,
  }) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: Cardcomponent.cardBackDecoration,
      child: child,
    );
  }

  static Container idiotClubRequestCart({
    required clubName,
    required description,
    required context,
  }) => Container(
    height: 200,
    width: 315,
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.only(bottom: 20),
    decoration: cardBackDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(clubName, style: clubTitleStyle),
        ),
        descriptionBox(
          text: description,
          height: 100,
          width: 275,
        ), //make changes
        Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          width: 287,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "11:11",
                style: TextStyle(
                  color: Color(0xFF5E5C5C),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, "/clubCreateReview"),
                child: Text(
                  "See Details->",
                  style: TextStyle(
                    color: Color(0xFF5E5C5C),
                    fontSize: 12,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  static Container descriptionBox({
    required String text,
    required double height,
    required double width,
    double fontSize = 14,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: cardDescriptionDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
          child: Textcomponents.whiteText(
            text: text,
            fontSize: fontSize,
            fontweight: FontWeight.normal,
          ),
          // child: Text(
          //   text,
          //   style: TextStyle(color: Colors.white, fontSize: 12),
          // ),
        ),
      ),
    );
  }

  static Container idiotClubCard({required clubName, required description}) {
    return Container(
      height: 200,
      width: 315,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: Cardcomponent.cardBackDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset("assets/images/Capi.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(clubName, style: Cardcomponent.clubTitleStyle),
                      RichText(
                        text: TextSpan(
                          text: "Club Member  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: "123",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Cardcomponent.descriptionBox(
            text: description,
            height: 100,
            width: 275,
          ), //make changes
        ],
      ),
    );
  }

  static Container idiotCommunityCard({
    required clubName,
    required description,
  }) {
    return Container(
      height: 200,
      width: 315,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: Cardcomponent.cardBackDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset("assets/images/PinPin.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(clubName, style: Cardcomponent.clubTitleStyle),
                      RichText(
                        text: TextSpan(
                          text: "Club Member  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: "123",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Cardcomponent.descriptionBox(
            text: description,
            height: 100,
            width: 275,
          ), //make changes
        ],
      ),
    );
  }
}
