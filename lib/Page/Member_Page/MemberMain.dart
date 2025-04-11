import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Page/Creator_Page/5_CommunityMember.dart';
import 'package:idiot_community_club_app/Page/Member_Page/2_CommunityMemberHome.dart';
import 'package:idiot_community_club_app/Page/Member_Page/4_MyCommunity.dart';
import 'package:idiot_community_club_app/Page/Member_Page/5_MemberProfile.dart';
import '../../Components/ButtonComponents.dart';
import '../../Providers/Member/member_provider.dart';

class MemberMainScreen extends ConsumerStatefulWidget {
  const MemberMainScreen({super.key});

  @override
  ConsumerState<MemberMainScreen> createState() => _MemberMainScreenState();
}

class _MemberMainScreenState extends ConsumerState<MemberMainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final member = ref.watch(memberProvider);

    // ⛔ Show a loading indicator if member is null
    if (member == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screens = [
      const CommunityMemberHome(),
      const MyCommunity(),
      const MemberProfile(),
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
            leading: Container(
              margin: const EdgeInsets.only(left: 0),
              width: 90,
              height: 90,
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/IdiotLogo.png",
                fit: BoxFit.contain,
                width: 90,
                height: 90,
              ),
            ),
          ),
        ),
      ),
      body: screens[_selectedIndex],
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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_sharp),
              label: 'MyCommunity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveIcon extends StatelessWidget {
  final IconData icon;
  const _ActiveIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.blue),
    );
  }
}
