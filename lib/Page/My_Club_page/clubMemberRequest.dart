import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:idiot_community_club_app/Components/CardComponents.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'package:idiot_community_club_app/Providers/Club/ClubJoinRequestListProvider.dart';
import 'package:idiot_community_club_app/Providers/Club/my_created_club_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';

class ClubMemberRequest extends ConsumerStatefulWidget {
  const ClubMemberRequest({super.key});

  @override
  ConsumerState<ClubMemberRequest> createState() =>
      _CommunityMemberrequestState();
}

class _CommunityMemberrequestState extends ConsumerState<ClubMemberRequest> {
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Delay until after first frame to access ref properly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final club = ref.watch(myCreatedClubStateProvider);
      if (club != null) {
        fetchClubJoinRequests(ref, club.clubId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final joinRequests = ref.watch(clubJoinRequestsProvider);
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
        title: Text("Club Members", style: TextStyle(color: Colors.white)),
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
      body: joinRequests.isEmpty
          ? Center(child: Text("No join requests."))
          : ListView.builder(
              itemCount: joinRequests.length,
              itemBuilder: (context, index) {
                return ListTileComponent_2.getListTile(
                    joinRequests[index], context, ref);
              },
            ),
    );
  }
}

class ListTileComponent_2 {
  static Widget getListTile(
      ClubJoinRequest user, BuildContext context, WidgetRef ref) {
    OverlayEntry? overlayEntry;

    void showOverlay() {
      final overlay = Overlay.of(context);

      overlayEntry = OverlayEntry(
        builder: (context) => Center(
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 320,
              height: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 29,
                          backgroundImage: getUserImage(user.userImage)),
                      const SizedBox(width: 2),
                      Text(
                        user.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "The reason why you want to join this community?",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  const SizedBox(height: 5),
                  Cardcomponent.descriptionBox(
                    text: user.reasonToJoin ?? "No reason provided.",
                    height: 120,
                    width: 280,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        overlayEntry?.remove();
                        overlayEntry = null;
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text("Close",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      overlay?.insert(overlayEntry!);
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
            radius: 29, backgroundImage: getUserImage(user.userImage)),
        title: Text(user.userName),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Accept"),
                        content: const Text(
                            "Are you sure you want to accept this request?"),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(), // Close dialog
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              final community =
                                  ref.read(currentCommunityProvider);
                              final club = ref.read(myCreatedClubStateProvider);
                              final leader = ref.read(memberProvider);
                              if (community != null &&
                                  club != null &&
                                  leader != null) {
                                await sendNewClubJoinDecision(
                                  communityId: community.communityId,
                                  clubLeaderId: leader.id,
                                  clubId: club.clubId,
                                  joinClubRequestId: user.requestId,
                                  requestStatus: RequestStatus.APPROVED,
                                  context: context,
                                );
                                fetchClubJoinRequests(
                                    ref, club.clubId);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text("Accept"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Accept"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Rejection"),
                        content: const Text(
                            "Are you sure you want to reject this request?"),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(), // Close dialog
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              final community =
                                  ref.read(currentCommunityProvider);
                              final club = ref.read(myCreatedClubStateProvider);
                              final leader = ref.read(memberProvider);
                              if (community != null &&
                                  club != null &&
                                  leader != null) {
                                await sendNewClubJoinDecision(
                                  communityId: community.communityId,
                                  clubLeaderId: leader.id,
                                  clubId: club.clubId,
                                  joinClubRequestId: user.requestId,
                                  requestStatus: RequestStatus.REJECTED,
                                  context: context,
                                );
                                fetchClubJoinRequests(
                                    ref, club.clubId);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("Reject"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Reject"),
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(FeatherIcons.layers, color: Colors.blue),
          onPressed: showOverlay,
        ),
      ),
    );
  }
}
