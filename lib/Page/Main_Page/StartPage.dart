import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Logo.png"),
                ButtonComponents.getLogoText("IDIOT"),
                ButtonComponents.getLogoText("COMMUNITY"),
                ButtonComponents.getLogoText("CLUB"),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/creatorStartPage");
                        },
                        child: ButtonComponents.getGradientBox(
                          text: "Community Create",
                          size: 16.0,
                          myRadius: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              "/memberStartPage",
                            ),
                        child: ButtonComponents.getGradientBox(
                          text: "Community Member",
                          size: 16.0,
                          myRadius: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
