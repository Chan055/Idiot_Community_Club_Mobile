import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idiot_community_club_app/Components/ButtonComponents.dart';
import 'package:idiot_community_club_app/Components/LoginComponent.dart';

class MemberLogin extends StatefulWidget {
  const MemberLogin({super.key});

  @override
  State<MemberLogin> createState() => _MemberLoginState();
}

class _MemberLoginState extends State<MemberLogin> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return ScreenDeco.getWholeGradientScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Image.asset("assets/images/WhiteLogo.png"),
                    SizedBox(height: 10),
                    ButtonComponents.getLogoText(
                      "IDIOT COMMUNITY CLUB",
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          ButtonComponents.getMyGradientText("Log In", 25),
                          ButtonComponents.getMyGradientText(
                            "Log in now to join amazing clubs",
                            12,
                          ),
                          SizedBox(height: 20),
                          ButtonComponents.getMyGradientText("Email", 18),
                          Loginwidget.inputBox(
                            myController: null,
                            getInput: (value) {
                              print(value);
                            },
                            myLabel: "Enter Your Email",
                          ),
                          ButtonComponents.getMyGradientText("Password", 18),
                          Loginwidget.inputBox(
                            getInput: (value) {
                              print(value);
                            },
                            myLabel: "Enter Your Password",
                            myObsecure: !showPassword,
                            password: true,
                            togglePassword: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            myController: null,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonComponents.getMyGradientText(
                                "Forget Password?",
                                12,
                              ),
                              SizedBox(width: 15),
                            ],
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/communityMemberHome",
                              );
                            },
                            child: ButtonComponents.getGradientBox(
                              text: "Login",
                              size: 20,
                              myRadius: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account?",
                                style: TextStyle(fontSize: 12),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/comReg");
                                },
                                child: ButtonComponents.getMyGradientText(
                                  "Register Now",
                                  12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenDeco {
  static Container getWholeGradientScreen({Widget? child}) {
    return Container(
      decoration: BoxDecoration(gradient: ButtonComponents.myGradientLTR),
      child: child,
    );
  }
}
