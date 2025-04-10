import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/CardComponents.dart';

class Barcomponents {
  static var selectedIndex = 0;
  static Stack idiotBar(Size screen) {
    return Stack(
      children: [
        Container(
          height: screen.height / 6.5,
          width: screen.width,
          decoration: BoxDecoration(gradient: ButtonComponents.myGradient),
        ),
        SafeArea(child: Image.asset("assets/images/IdiotLogo.png")),
      ],
    );
  }

  static Stack idiotClubBar(Size screen, context) {
    return Stack(
      children: [
        Container(
          height: screen.height / 6.5,
          width: screen.width,
          decoration: BoxDecoration(gradient: ButtonComponents.myGradient),
        ),
        SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, "/myCommunity"),
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
              ClipOval(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset("assets/images/PinPin.png"),
                ),
              ),
              SizedBox(width: 10),
              Text("MFU Community", style: Cardcomponent.clubTitleStyle),
            ],
          ),
        ),
      ],
    );
  }

  // static AppBar idiotAppBar = AppBar(
  //   leading: Image.asset("assets/images/IdiotLogo.png"),
  //   flexibleSpace: Container(
  //     decoration: BoxDecoration(
  //       gradient: ButtonComponents.myGradient,
  //     ),
  //   ),
  // );

  static Container getIdiotNav(screen, context) {
    return Container(
      height: screen.height / 7,
      width: screen.width,
      decoration: BoxDecoration(gradient: ButtonComponents.myGradient),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 0,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        onTap: (value) {
          selectedIndex = value;
          switch (value) {
            case 0:
              Navigator.pushNamed(context, "/home");
              break;
            case 1:
              Navigator.pushNamed(context, "/member");
              break;
            case 2:
              Navigator.pushNamed(context, "/club");
              break;
            case 3:
              Navigator.pushNamed(context, "/profile");
              break;
          }
        },
        items: [
          _buildNavItem(Icons.home_outlined, "Home", 0),
          _buildNavItem(Icons.group_add_outlined, "Member", 1),
          _buildNavItem(Icons.people_outline_sharp, "Club", 2),
          _buildNavItem(Icons.person_outlined, "Profile", 3),
        ],
      ),
    );
  }

  static Container getIdiotClubNav(screen, context) {
    return Container(
      height: screen.height / 7,
      width: screen.width,
      decoration: BoxDecoration(gradient: ButtonComponents.myGradient),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 0,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        onTap: (value) {
          selectedIndex = value;
          switch (value) {
            case 0:
              Navigator.pushNamed(context, "/clubHome");
              break;
            case 1:
              Navigator.pushNamed(context, "/myClub");
              break;
            case 2:
              Navigator.pushNamed(context, "/joiedClub");
              break;
          }
        },
        items: [
          _buildNavItem(Icons.home_outlined, "Home", 0),
          _buildNavItem(Icons.add_circle_outline, "MyClub", 1),
          _buildNavItem(Icons.people_outline_sharp, "JoiedClub", 2),
        ],
      ),
    );
  }

  static Container getIdiotCommunityNav(screen, context) {
    return Container(
      height: screen.height / 7,
      width: screen.width,
      decoration: BoxDecoration(gradient: ButtonComponents.myGradient),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 0,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        onTap: (value) {
          selectedIndex = value;
          switch (value) {
            case 0:
              Navigator.pushNamed(context, "/communityMemberHome");
              break;
            case 1:
              Navigator.pushNamed(context, "/myCommunity");
              break;
            case 2:
              Navigator.pushNamed(context, "/memberProfile");
              break;
          }
        },
        items: [
          _buildNavItem(Icons.home_outlined, "Home", 0),
          _buildNavItem(Icons.people_outline_sharp, "MyCommunity", 1),
          _buildNavItem(Icons.person_outlined, "Profile", 2),
        ],
      ),
    );
  }

  static BottomNavigationBarItem _buildNavItem(icon, text, index) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            selectedIndex == index
                ? Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
                : Container(),
            Center(
              child:
                  selectedIndex == index
                      ? ButtonComponents.myGradientLogo(icon)
                      : Icon(icon, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
      label: selectedIndex == index ? "" : text,
    );
  }

  static Stack getIdiotSearchBar({required String text}) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(38),
          height: 55,
          width: 320,
          decoration: BoxDecoration(
            gradient: ButtonComponents.myGradient,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(40),
          height: 50,
          width: 314,
          child: SearchBar(
            backgroundColor: WidgetStateProperty.all(
              const Color.fromARGB(255, 255, 255, 255),
            ),
            leading: Icon(Icons.search, size: 30),
            hintText: text,
          ),
        ),
      ],
    );
  }
}
