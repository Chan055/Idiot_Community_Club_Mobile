import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Page/Club_Page/0_ClubHome.dart';
import 'package:idiot_community_club_app/Page/Club_Page/2_MyClubForm.dart';
import 'package:idiot_community_club_app/Page/Club_Page/3_MyCreatedClub.dart';
import 'package:idiot_community_club_app/Page/Club_Page/4_JoiedClubs.dart';
import 'package:idiot_community_club_app/Providers/Member/current_community_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/member_provider.dart';
import 'package:idiot_community_club_app/Providers/Member/my_community_list_provider.dart';

class ClubMainScreen extends ConsumerStatefulWidget {
  const ClubMainScreen({super.key});

  @override
  ConsumerState<ClubMainScreen> createState() => _ClubMainScreenState();
}

class _ClubMainScreenState extends ConsumerState<ClubMainScreen> {
  int _selectedIndex = 0;

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    final member = ref.read(memberProvider);
    if (member != null) {
      await fetchMyCommunity(ref, member.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCommunity = ref.watch(currentCommunityProvider);

    if (currentCommunity == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isLeader = currentCommunity.isLeader;

    final List<Widget> _screens = [
      const ClubHome(),
      isLeader ? const MyCreatedClub() : const MyClubForm(),
      const JoinedClub(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: ButtonComponents.myGradient,
          ),
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
                color: Colors.white,
                iconSize: 30,
              )),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Clubs",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'My Club',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Joined Clubs',
            ),
          ],
        ),
      ),
    );
  }
}
