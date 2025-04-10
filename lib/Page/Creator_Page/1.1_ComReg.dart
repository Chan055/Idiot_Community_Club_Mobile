import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/LoginComponent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '1_CreatorLogin.dart';

class ComReg extends StatefulWidget {
  const ComReg({super.key});

  @override
  State<ComReg> createState() => _ComRegState();
}

class _ComRegState extends State<ComReg> {
  bool showPassword = false;
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (passwordController.text != rePasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Passwords do not match")),
      );
      return;
    }

    final url = Uri.parse("http://localhost:8080/api/creator/signup");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": userNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    final resBody = jsonDecode(response.body);

    if (resBody["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ ${resBody["message"]}")),
      );
      Navigator.pushReplacementNamed(context, "/creatorLogin");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Sign up failed: ${resBody["message"]}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDeco.getWholeGradientScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset("assets/images/WhiteLogo.png"),
                  SizedBox(height: 10),
                  ButtonComponents.getLogoText(
                    "IDIOT COMMUNITY CLUB",
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonComponents.getMyGradientText("Sign Up", 25),
                          ButtonComponents.getMyGradientText("Sign up now to join amazing clubs!", 12),
                          SizedBox(height: 20),

                          ButtonComponents.getMyGradientText("Username", 18),
                          ScreenDeco.inputBox(
                            myController: userNameController,
                            getInput: (_) {},
                            myLabel: "Enter Your Username",
                          ),

                          ButtonComponents.getMyGradientText("Email", 18),
                          ScreenDeco.inputBox(
                            myController: emailController,
                            getInput: (_) {},
                            myLabel: "Enter Your Email",
                          ),

                          ButtonComponents.getMyGradientText("Password", 18),
                          ScreenDeco.inputBox(
                            getInput: (_) {},
                            myLabel: "Enter Your Password",
                            myObsecure: !showPassword,
                            password: true,
                            togglePassword: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            myController: passwordController,
                          ),

                          ButtonComponents.getMyGradientText("Re-Enter Password", 18),
                          ScreenDeco.inputBox(
                            getInput: (_) {},
                            myLabel: "Confirm Your Password",
                            myObsecure: !showPassword,
                            password: true,
                            togglePassword: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            myController: rePasswordController,
                          ),

                          SizedBox(height: 20),

                          InkWell(
                            onTap: registerUser,
                            child: ScreenDeco.getGradientBox(
                              text: "Sign Up",
                              size: 20,
                              myRadius: 12,
                            ),
                          ),

                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?", style: TextStyle(fontSize: 12)),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/creatorLogin");
                                },
                                child: ButtonComponents.getMyGradientText("Log in", 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

      ),
    );
  }
}
