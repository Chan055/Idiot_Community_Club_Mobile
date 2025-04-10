import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/BarComponents.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';

class MemberProfile extends StatefulWidget {
  const MemberProfile({super.key});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screen.height / 2.8,
                width: screen.width,
                decoration: BoxDecoration(
                  gradient: ButtonComponents.myGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
              SafeArea(child: Image.asset("assets/images/IdiotLogo.png")),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.only(top: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.asset("assets/images/RedPanda.jpeg"),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Level:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "User",
                              style: TextStyle(
                                color: Color(0xFFFFDC51),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 31,
                          width: 31,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ButtonComponents.myGradientLogo(
                            Icons.edit_square,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 20),
              _getMyProfile(Icons.person_2_outlined, "Name:Kit Kat"),
              _getMyLine(),
              _getMyProfile(Icons.email_outlined, "Email:kit.kat@gmail.com"),
              _getMyLine(),
              InkWell(
                onTap: () => Navigator.pushNamed(context, "/"),
                child: _getMyProfile(Icons.logout, "Logout"),
              ),
              _getMyLine(),
            ],
          ),
          Flexible(child: Container()),
        ],
      ),
      bottomNavigationBar: Barcomponents.getIdiotCommunityNav(screen, context),
    );
  }
}

Container _getMyProfile(icon, text) {
  return Container(
    padding: EdgeInsets.only(left: 110, top: 10, bottom: 10),
    child: Row(
      children: [
        ButtonComponents.myGradientLogo(icon),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}

Divider _getMyLine() {
  return Divider(color: const Color.fromARGB(84, 0, 0, 0), thickness: 2);
}
