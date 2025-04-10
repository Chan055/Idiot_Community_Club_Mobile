import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';

class LuanchPage extends StatefulWidget {
  const LuanchPage({super.key});

  @override
  State<LuanchPage> createState() => _LuanchPageState();
}

class _LuanchPageState extends State<LuanchPage> {
  goToFirst() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamed(context, "/startPage");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    goToFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Logo.png"),
                ButtonComponents.getLogoText("IDIOT"),
                ButtonComponents.getLogoText("COMMUNITY"),
                ButtonComponents.getLogoText("CLUB"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
