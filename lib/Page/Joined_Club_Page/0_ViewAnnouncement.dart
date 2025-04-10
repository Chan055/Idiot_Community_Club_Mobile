import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Models/CommunityMemberModel.dart';

class ViewAnnouncement extends StatefulWidget {
  const ViewAnnouncement({super.key});

  @override
  State<ViewAnnouncement> createState() => _ViewAnnouncementState();
}

double myHeight = 180;

class _ViewAnnouncementState extends State<ViewAnnouncement> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 0,
          ), // Optional padding for aesthetics
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Navigate back
            },
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensure Row takes only necessary space
              children: [const Icon(Icons.arrow_back, color: Colors.white)],
            ),
          ),
        ),
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                "assets/images/Capi.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Yoga Club",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: Colors.white54,
            // Background color of the popup
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            onSelected: (value) {
              if (value == "Page1") {
                Navigator.pushNamed(context, '/joinedClubMembers');
              } else if (value == "Page2") {
                Navigator.pushNamed(context, '/joinedClubDetail');
              } else if (value == "Page3") {
                Navigator.pop(context);
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: "Page1", child: Text("Club Member")),
                  PopupMenuItem(value: "Page2", child: Text("Club Detail")),
                  PopupMenuItem(value: "Page3", child: Text("Leave Club")),
                ],
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              reverse: true,
              itemCount: User.myMessages.length,
              itemBuilder: (context, index) {
                double myLength = User.myMessages[index].message.length / 24;
                double myH = myLength < 7 ? myLength * 30 : myLength * 21;
                ;
                return Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 20, bottom: 5),
                    padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                    width: 250,
                    height: myH,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      gradient: ButtonComponents.myGradient,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: myH - 30,
                          width: 220,
                          child: Text(
                            User.myMessages[index].message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "11:11",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
