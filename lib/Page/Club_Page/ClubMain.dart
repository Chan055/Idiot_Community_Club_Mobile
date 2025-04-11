import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Page/Club_Page/0_ClubHome.dart';
import 'package:idiot_community_club_app/Page/Club_Page/2_MyClubForm.dart';
import 'package:idiot_community_club_app/Page/Club_Page/4_JoiedClubs.dart';

class ClubMainScreen extends StatefulWidget {
  const ClubMainScreen({super.key});

  @override
  State<ClubMainScreen> createState() => _ClubMainScreenState();
}

class _ClubMainScreenState extends State<ClubMainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    const ClubHome(),
    const MyClubForm(),
    const JoinedClub(),
  ];

  @override
  Widget build(BuildContext context) {
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
