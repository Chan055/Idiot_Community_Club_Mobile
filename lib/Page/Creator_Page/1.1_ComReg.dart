import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Models/Constant.dart';
import '1_CreatorLogin.dart';

class ComReg extends StatefulWidget {
  const ComReg({super.key});

  @override
  State<ComReg> createState() => _ComRegState();
}

class _ComRegState extends State<ComReg> {
  bool showPassword = false;
  bool agreeToTerms = false;
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
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("❌ Please agree to the terms and conditions.")),
      );
      return;
    }

    if (passwordController.text != rePasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Passwords do not match")),
      );
      return;
    }

    final url = Uri.parse("$BASE_URL/api/creator/signup");

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
                const SizedBox(height: 50),
                Image.asset("assets/images/WhiteLogo.png"),
                const SizedBox(height: 10),
                ButtonComponents.getLogoText(
                  "IDIOT COMMUNITY CLUB",
                  fontSize: 24,
                  color: Colors.white,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ButtonComponents.getMyGradientText("Sign Up", 25),
                        ButtonComponents.getMyGradientText(
                            "Sign up now to join amazing clubs!", 12),
                        const SizedBox(height: 20),
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
                          togglePassword: () =>
                              setState(() => showPassword = !showPassword),
                          myController: passwordController,
                        ),
                        ButtonComponents.getMyGradientText(
                            "Re-Enter Password", 18),
                        ScreenDeco.inputBox(
                          getInput: (_) {},
                          myLabel: "Confirm Your Password",
                          myObsecure: !showPassword,
                          password: true,
                          togglePassword: () =>
                              setState(() => showPassword = !showPassword),
                          myController: rePasswordController,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: agreeToTerms,
                                  onChanged: (value) =>
                                      setState(() => agreeToTerms = value!),
                                ),
                                const Expanded(
                                  child: Text(
                                    "By clicking this button, you agree to our ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/termsOfUse");
                                  },
                                  child: gradientText(
                                      "Terms of Use", 12, FontWeight.bold),
                                ),
                                const Text(
                                  " and ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, "/privacyAndPolicy"),
                                  child: gradientText("Privacy and policy", 12,
                                      FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: registerUser,
                          child: ScreenDeco.getGradientBox(
                            text: "Sign Up",
                            size: 20,
                            myRadius: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",
                                style: TextStyle(fontSize: 12)),
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/creatorLogin"),
                              child: ButtonComponents.getMyGradientText(
                                  "Log in", 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
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
