import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Models/Constant.dart';
import 'dart:convert';

import '../../Providers/member_provider.dart';

class MemberLogin extends ConsumerStatefulWidget {
  const MemberLogin({super.key});

  @override
  ConsumerState<MemberLogin> createState() => _MemberLoginState();
}

class _MemberLoginState extends ConsumerState<MemberLogin> {
  bool showPassword = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final url = Uri.parse("$BASE_URL/api/member/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    final resBody = jsonDecode(response.body);
    print(resBody);

    if (resBody["success"] == true) {
      ref.read(memberProvider.notifier).state =
          Member.fromJson(resBody["data"]);
      print(ref.watch(memberProvider)?.name);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ ${resBody["message"]}")),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/communityMemberHome');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Login failed: ${resBody["message"]}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDeco.getWholeGradientScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),
                Image.asset("assets/images/WhiteLogo.png"),
                SizedBox(height: 10),
                Text(
                  "IDIOT COMMUNITY CLUB",
                  style: TextStyle(
                    fontFamily: GoogleFonts.zenTokyoZoo().fontFamily,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 70),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gradientText("Log In", 25, FontWeight.bold),
                      gradientText("Log in Now to join amazing clubs", 12,
                          FontWeight.bold),
                      SizedBox(height: 20),
                      gradientText("Email", 18, FontWeight.bold),
                      ScreenDeco.inputBox(
                        myController: emailController,
                        getInput: (_) {},
                        myLabel: "Enter Your Email",
                      ),
                      gradientText("Password", 18, FontWeight.bold),
                      ScreenDeco.inputBox(
                        myController: passwordController,
                        getInput: (_) {},
                        myLabel: "Enter Your Password",
                        myObsecure: !showPassword,
                        password: true,
                        togglePassword: () {
                          setState(() => showPassword = !showPassword);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          gradientText("Forget Password?", 12, FontWeight.bold),
                          SizedBox(width: 15),
                        ],
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: loginUser,
                        child: ScreenDeco.getGradientBox(
                          text: "Login",
                          size: 20,
                          myRadius: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account?",
                              style: TextStyle(fontSize: 12)),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/memReg");
                            },
                            child: gradientText(
                                "Register Now", 12, FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 180),
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

  Widget gradientText(String text, double size, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 50.0)),
      ),
    );
  }
}

class ScreenDeco {
  static Container getWholeGradientScreen({Widget? child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: child,
    );
  }

  static Container inputBox({
    getInput,
    myLabel,
    bool myObsecure = false,
    password = false,
    VoidCallback? togglePassword,
    required myController,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        color: Color.fromARGB(92, 106, 132, 235),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        controller: myController,
        obscureText: myObsecure,
        onChanged: getInput,
        decoration: InputDecoration(
          suffixIcon: password
              ? IconButton(
                  onPressed: togglePassword,
                  icon: myObsecure
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : null,
          labelText: myLabel,
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  static Container getGradientBox({
    required text,
    required double size,
    required double myRadius,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF52C8FF), Color(0xFF6A84EB)],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(myRadius),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: size),
        ),
      ),
    );
  }
}
