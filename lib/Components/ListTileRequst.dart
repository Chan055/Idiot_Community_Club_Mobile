import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Models/RandomUser.dart';
import 'package:idiot_community_club_app/Models/User.dart';

class ListTileComponent {
  static Widget getListTile_1(RandomUser user) {
    OverlayEntry? overlayEntry;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage:
              user.picture?.large != null && user.picture!.large!.isNotEmpty
                  ? NetworkImage(user.picture!.large!)
                  : AssetImage("assets/profile_placeholder.png")
                      as ImageProvider, // Local image fallback
          onBackgroundImageError:
              (_, __) => const Icon(Icons.person, size: 30, color: Colors.grey),
        ),
        title: Text(
          "${user.name?.title} ${user.name?.first} ${user.name?.last}",
        ),
        trailing: Icon(Icons.more_vert, size: 25, color: Colors.black45),
      ),
    );
  }

  static Widget getListTile(User user, BuildContext context) {
    OverlayEntry? overlayEntry;

    void showOverlay() {
      final overlay = Overlay.of(context);

      overlayEntry = OverlayEntry(
        builder:
            (context) => Center(
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 320,
                  height: 320,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 29,
                              backgroundImage:
                                  user.image != null && user.image.isNotEmpty
                                      ? NetworkImage(user.image)
                                      : AssetImage(
                                            "assets/profile_placeholder.png",
                                          )
                                          as ImageProvider,
                            ),
                            SizedBox(width: 10),
                            Text(
                              user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "The reason why you want to join this Conmunity?",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Cardcomponent.descriptionBox(
                          text:
                              "I am a chess enthusiast and I would like to join this community to learn more about the game and meet other chess players.",
                          height: 145,
                          width: 280,
                        ),

                        // Container(
                        //   width: 280,
                        //   height: 145,
                        //   decoration: BoxDecoration(
                        //     color: const Color.fromARGB(41, 10, 10, 10),
                        //     border: Border.all(color: Colors.white, width: 1),
                        //     borderRadius: BorderRadius.circular(12),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(
                        //       "I am a chess enthusiast and I would like to join this community to learn more about the game and meet other chess players.",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 14,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            overlayEntry?.remove();
                            overlayEntry = null;
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Close",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      );

      overlay?.insert(overlayEntry!);
    }

    return Card(
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 29,
            backgroundImage:
                user.image != null && user.image.isNotEmpty
                    ? NetworkImage(user.image)
                    : AssetImage("assets/profile_placeholder.png")
                        as ImageProvider,
          ),
        ),
        title: Text("${user.name}"),
        subtitle: Container(
          margin: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 33,
                decoration: BoxDecoration(
                  gradient: ButtonComponents.acceptButton(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(80, 15),
                  ),
                  onPressed: () {},
                  child: Text("Accept", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 100,
                height: 33,
                decoration: BoxDecoration(
                  gradient: ButtonComponents.rejectButton(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(80, 15),
                  ),
                  onPressed: () {},
                  child: Text("Reject", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        trailing: InkWell(
          onTap: () {
            showOverlay();
          },
          child: Icon(FeatherIcons.layers, size: 25, color: Colors.blue),
        ),
      ),
    );
  }
}
