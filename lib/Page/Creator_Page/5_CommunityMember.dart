import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:idiot_community_club_app/Components/CardComponents.dart';

import 'package:idiot_community_club_app/Providers/Creator/community_provider.dart';
import 'package:idiot_community_club_app/Providers/Creator/creator_provider.dart';
import 'package:idiot_community_club_app/Providers/Creator/join_request_provider.dart';

class CommunityMemberrequest extends ConsumerStatefulWidget {
  const CommunityMemberrequest({super.key});

  @override
  ConsumerState<CommunityMemberrequest> createState() =>
      _CommunityMemberrequestState();
}

class _CommunityMemberrequestState
    extends ConsumerState<CommunityMemberrequest> {
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Delay until after first frame to access ref properly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final community = ref.read(communityProvider);
      if (community != null) {
        fetchJoinRequests(ref, community.communityId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final joinRequests = ref.watch(joinRequestProvider);
    return Scaffold(
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
      JoinRequest user, BuildContext context, WidgetRef ref) {
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
                        backgroundImage: user.userPhoto != null &&
                                user.userPhoto!.isNotEmpty
                            ? FileImage(File(user.userPhoto!))
                            : const AssetImage("assets/images/IdiotLogo.png")
                                as ImageProvider,
                      ),
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
                  FutureBuilder<String>(
                    future: fetchJoinReason(user.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return Cardcomponent.descriptionBox(
                          text: snapshot.data ?? "No reason provided.",
                          height: 120,
                          width: 280,
                        );
                      }
                    },
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
          radius: 29,
          backgroundImage: user.userPhoto != null && user.userPhoto!.isNotEmpty
              ? FileImage(File(user.userPhoto!))
              : const AssetImage("assets/images/IdiotLogo.png")
                  as ImageProvider,
        ),
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
                              Navigator.of(context).pop(); // Close dialog
                              final creator = ref.read(creatorProvider);
                              final community = ref.read(communityProvider);
                              if (creator != null && community != null) {
                                await sendJoinRequestDecision(
                                  status: RequestStatus.APPROVED,
                                  joinCommunityRequestId: user.joinRequestId,
                                  userId: user.userId,
                                  communityCreatorId: creator.id,
                                  communityId: community.communityId,
                                  context: context,
                                );
                                fetchJoinRequests(ref, community.communityId);
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
                              Navigator.of(context).pop(); // Close dialog
                              final creator = ref.read(creatorProvider);
                              final community = ref.read(communityProvider);
                              if (creator != null && community != null) {
                                await sendJoinRequestDecision(
                                  status: RequestStatus.REJECTED,
                                  joinCommunityRequestId: user.joinRequestId,
                                  userId: user.userId,
                                  communityCreatorId: creator.id,
                                  communityId: community.communityId,
                                  context: context,
                                );
                                fetchJoinRequests(ref, community.communityId);
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
