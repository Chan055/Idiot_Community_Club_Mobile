import 'dart:io';

import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Helper/MyImagePicker.dart';
import 'package:idiot_community_club_app/Providers/Club/JoinedClubProvider.dart';
import 'package:idiot_community_club_app/Providers/Club/current_club_provider.dart';

class JoinedClubDetail extends StatefulWidget {
  const JoinedClubDetail({super.key});

  @override
  State<JoinedClubDetail> createState() => _JoinedClubDetailState();
}

class _JoinedClubDetailState extends State<JoinedClubDetail> {
  @override
  Widget build(BuildContext context) {
    final Club club = ModalRoute.of(context)!.settings.arguments as Club;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Club Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 2, // Border width
                      ),
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: ClipOval(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: buildCommunityImage(club.clubLogo),
                      ),
                    )),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "${club.clubName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 350,
                  height: 200,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 2, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.info_outline, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          "${club.clubDescription}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
