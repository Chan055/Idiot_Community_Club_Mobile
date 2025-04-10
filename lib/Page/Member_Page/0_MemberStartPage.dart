import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';

class MemberStartPage extends StatelessWidget {
  const MemberStartPage({super.key});

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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Image.asset("assets/images/Logo.png"),
                ),
                ButtonComponents.getLogoText("IDIOT"),
                ButtonComponents.getLogoText("COMMUNITY"),
                ButtonComponents.getLogoText("CLUB"),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/memberLogin");
                        },
                        child: ButtonComponents.getGradientBox(
                          text: "Log In",
                          size: 16.0,
                          myRadius: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onDoubleTap: () {
                          Navigator.pushNamed(context, "/comReg");
                        },
                        child: ButtonComponents.getLogInBorder("Sign Up"),
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
